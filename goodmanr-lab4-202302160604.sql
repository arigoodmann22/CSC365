-- Lab 4
-- goodmanr
-- Feb 16, 2023

USE `STUDENTS`;
-- STUDENTS-1
-- Find all students who study in classroom 111. For each student list first and last name. Sort the output by the last name of the student.
SELECT FirstName, LastName
FROM list
WHERE Classroom = 111
ORDER BY LastName;


USE `STUDENTS`;
-- STUDENTS-2
-- For each classroom report the grade that is taught in it. Report just the classroom number and the grade number. Sort output by classroom in descending order.
SELECT DISTINCT Classroom, Grade 
FROM list
ORDER BY Classroom DESC;


USE `STUDENTS`;
-- STUDENTS-3
-- Find all teachers who teach fifth grade. Report first and last name of the teachers and the room number. Sort the output by room number.
SELECT DISTINCT teachers.First, teachers.Last, teachers.Classroom
FROM teachers
    INNER JOIN list ON teachers.Classroom = list.Classroom
WHERE Grade = 5
ORDER BY Classroom;


USE `STUDENTS`;
-- STUDENTS-4
-- Find all students taught by OTHA MOYER. Output first and last names of students sorted in alphabetical order by their last name.
SELECT DISTINCT FirstName, LastName
FROM list
    INNER JOIN teachers ON teachers.Classroom = list.Classroom
WHERE teachers.First = "OTHA" AND teachers.Last = "MOYER"
ORDER BY LastName;


USE `STUDENTS`;
-- STUDENTS-5
-- For each teacher teaching grades K through 3, report the grade (s)he teaches. Output teacher last name, first name, and grade. Each name has to be reported exactly once. Sort the output by grade and alphabetically by teacher’s last name for each grade.
SELECT DISTINCT teachers.Last, teachers.First, list.Grade
FROM teachers 
	INNER JOIN list ON teachers.classroom = list.classroom
WHERE list.Grade <= 3 
ORDER BY grade, teachers.Last;


USE `BAKERY`;
-- BAKERY-1
-- Find all chocolate-flavored items on the menu whose price is under $5.00. For each item output the flavor, the name (food type) of the item, and the price. Sort your output in descending order by price.
SELECT Flavor, Food, Price
FROM goods
WHERE Flavor = 'Chocolate' and Price < 5
ORDER BY Price DESC;


USE `BAKERY`;
-- BAKERY-2
-- Report the prices of the following items (a) any cookie priced above $1.10, (b) any lemon-flavored items, or (c) any apple-flavored item except for the pie. Output the flavor, the name (food type) and the price of each pastry. Sort the output in alphabetical order by the flavor and then pastry name.
SELECT Flavor, Food, Price
FROM goods
WHERE (Price > 1.1 and Food = 'Cookie') or (Flavor = 'Lemon') or (Flavor = 'Apple' and Food != 'Pie')
ORDER BY Flavor, Food, Price;


USE `BAKERY`;
-- BAKERY-3
-- Find all customers who made a purchase on October 3, 2007. Report the name of the customer (last, first). Sort the output in alphabetical order by the customer’s last name. Each customer name must appear at most once.
SELECT DISTINCT LastName, FirstName
FROM customers
INNER JOIN receipts ON customers.CId = receipts.Customer
WHERE receipts.SaleDate = "2007-10-03"
ORDER BY LastName;


USE `BAKERY`;
-- BAKERY-4
-- Find all different cakes purchased on October 4, 2007. Each cake (flavor, food) is to be listed once. Sort output in alphabetical order by the cake flavor.
SELECT DISTINCT Flavor, Food
FROM goods
INNER JOIN items on goods.GID = items.item
INNER JOIN receipts ON items.Receipt = receipts.RNumber
WHERE receipts.SaleDate = '2007-10-04' and Food = 'Cake' 
ORDER BY Flavor, Food;


USE `BAKERY`;
-- BAKERY-5
-- List all pastries purchased by ARIANE CRUZEN on October 25, 2007. For each pastry, specify its flavor and type, as well as the price. Output the pastries in the order in which they appear on the receipt (each pastry needs to appear the number of times it was purchased).
SELECT Flavor, Food, Price
FROM goods
INNER JOIN items on items.Item = goods.GID
INNER JOIN receipts on receipts.RNumber = items.Receipt
INNER JOIN customers on customers.CID = receipts.Customer
WHERE customers.FirstName = 'ARIANE' and customers.LastName = 'CRUZEN' and receipts.SaleDate = '2007-10-25';


USE `BAKERY`;
-- BAKERY-6
-- Find all types of cookies purchased by KIP ARNN during the month of October of 2007. Report each cookie type (flavor, food type) exactly once in alphabetical order by flavor.

SELECT DISTINCT Flavor, Food
FROM goods
INNER JOIN items on items.Item = goods.GID
INNER JOIN receipts on receipts.RNumber = items.Receipt
INNER JOIN customers on customers.CID = receipts.Customer
WHERE receipts.SaleDate >= '2007-10-01' and receipts.SaleDate <= '2007-10-31' and Food = 'Cookie' and customers.FirstName = 'KIP' and customers.LastName = 'ARNN'
ORDER BY Flavor;


USE `CSU`;
-- CSU-1
-- Report all campuses from Los Angeles county. Output the full name of campus in alphabetical order.
SELECT Campus
FROM campuses
WHERE County = 'Los Angeles'
ORDER BY Campus;


USE `CSU`;
-- CSU-2
-- For each year between 1994 and 2000 (inclusive) report the number of students who graduated from California Maritime Academy Output the year and the number of degrees granted. Sort output by year.
SELECT degrees.Year, degrees.Degrees
FROM degrees
INNER JOIN campuses on campuses.Id = degrees.CampusId
WHERE degrees.Year >= 1994 and degrees.Year <= 2000 and campuses.Campus = 'California Maritime Academy'
ORDER BY degrees.Year;


USE `CSU`;
-- CSU-3
-- Report undergraduate and graduate enrollments (as two numbers) in ’Mathematics’, ’Engineering’ and ’Computer and Info. Sciences’ disciplines for both Polytechnic universities of the CSU system in 2004. Output the name of the campus, the discipline and the number of graduate and the number of undergraduate students enrolled. Sort output by campus name, and by discipline for each campus.
SELECT DISTINCT campuses.campus, disciplines.Name, discEnr.Gr, discEnr.Ug
FROM degrees
INNER JOIN campuses on campuses.Id = degrees.CampusId
INNER JOIN discEnr on discEnr.CampusId = campuses.id
INNER JOIN disciplines on disciplines.Id = discEnr.Discipline
WHERE (disciplines.Name = "Engineering" or disciplines.Name = "Mathematics" or disciplines.Name = "Computer and Info. Sciences") and campuses.campus like "%Polytechnic%"
ORDER BY campuses.campus, disciplines.Name;


USE `CSU`;
-- CSU-4
-- Report graduate enrollments in 2004 in ’Agriculture’ and ’Biological Sciences’ for any university that offers graduate studies in both disciplines. Report one line per university (with the two grad. enrollment numbers in separate columns), sort universities in descending order by the number of ’Agriculture’ graduate students.
SELECT Campus, dE1.Gr AS 'Agriculture', dE2.Gr AS 'Biological Sciences'
FROM discEnr AS dE1
    INNER JOIN discEnr as dE2 ON dE2.CampusId = dE1.CampusId 
    INNER JOIN campuses ON campuses.Id = dE1.CampusId
    INNER JOIN disciplines AS D1 ON D1.Id = dE1.Discipline  
    INNER JOIN disciplines AS D2 ON D2.Id = dE2.Discipline  
WHERE D1.Name ='Agriculture' AND D2.Name='Biological Sciences' AND dE1.Gr > 0 AND dE2.Gr > 0 
ORDER BY dE1.Gr DESC;


USE `CSU`;
-- CSU-5
-- Find all disciplines and campuses where graduate enrollment in 2004 was at least three times higher than undergraduate enrollment. Report campus names, discipline names, and both enrollment counts. Sort output by campus name, then by discipline name in alphabetical order.
SELECT Campus, Name, Ug, Gr 
FROM campuses
INNER JOIN discEnr ON discEnr.CampusId = campuses.Id 
INNER JOIN disciplines ON disciplines.Id = discEnr.Discipline 
WHERE discEnr.Year = 2004 AND Gr >= Ug*3 
ORDER BY Campus, Name;


USE `CSU`;
-- CSU-6
-- Report the amount of money collected from student fees (use the full-time equivalent enrollment for computations) at ’Fresno State University’ for each year between 2002 and 2004 inclusively, and the amount of money (rounded to the nearest penny) collected from student fees per each full-time equivalent faculty. Output the year, the two computed numbers sorted chronologically by year.
SELECT enrollments.Year, (enrollments.FTE * fee) AS 'COLLECTED', ROUND((enrollments.FTE * fee)/faculty.FTE , 2) AS 'PER FACULTY' 
FROM enrollments
    INNER JOIN faculty ON  faculty.CampusId = enrollments.CampusId
    INNER JOIN campuses ON campuses.Id = enrollments.CampusId AND campuses.Id = faculty.CampusId 
    INNER JOIN fees ON fees.CampusId = enrollments.CampusId AND fees.CampusId = campuses.Id
WHERE Campus = 'Fresno State University' and enrollments.Year >= 2002 and enrollments.Year <= 2004 and fees.Year = enrollments.Year and faculty.Year = enrollments.Year 
ORDER BY enrollments.Year;


USE `CSU`;
-- CSU-7
-- Find all campuses where enrollment in 2003 (use the FTE numbers), was higher than the 2003 enrollment in ’San Jose State University’. Report the name of campus, the 2003 enrollment number, the number of faculty teaching that year, and the student-to-faculty ratio, rounded to one decimal place. Sort output in ascending order by student-to-faculty ratio.
SELECT campuses.Campus, enrollments.FTE, faculty.FTE, ROUND(enrollments.FTE/faculty.FTE, 1) AS 'RATIO'
FROM campuses
    INNER JOIN enrollments ON enrollments.CampusId = campuses.Id 
    INNER JOIN faculty ON  faculty.CampusId = enrollments.CampusId
    INNER JOIN enrollments AS eSJ
    INNER JOIN campuses AS cSJ ON eSJ.CampusId = cSJ.Id 
WHERE eSJ.year = 2003 AND cSJ.Campus = 'San Jose State University' AND enrollments.Year = 2003 AND enrollments.FTE > eSJ.FTE AND faculty.Year = enrollments.Year 
ORDER BY RATIO ASC;


USE `INN`;
-- INN-1
-- Find all modern rooms with a base price below $160 and two beds. Report room code and full room name, in alphabetical order by the code.
SELECT RoomCode, roomName
FROM rooms
WHERE decor = 'modern' and basePrice < 160.0 and beds = 2
ORDER BY RoomCode;


USE `INN`;
-- INN-2
-- Find all July 2010 reservations (a.k.a., all reservations that both start AND end during July 2010) for the ’Convoke and sanguine’ room. For each reservation report the last name of the person who reserved it, checkin and checkout dates, the total number of people staying and the daily rate. Output reservations in chronological order.
SELECT LastName, (select reservations.checkIn) as checkin, (select reservations.checkOut) as checkout, (select reservations.Adults + reservations.Kids) as Guests, Rate
FROM rooms
INNER JOIN reservations ON rooms.RoomCode = reservations.Room
WHERE roomName = 'Convoke and sanguine' AND reservations.CheckIn >= '2010-07-01' AND reservations.CheckOut <= '2010-07-31' 
ORDER BY CheckIn;


USE `INN`;
-- INN-3
-- Find all rooms occupied on February 6, 2010. Report full name of the room, the check-in and checkout dates of the reservation. Sort output in alphabetical order by room name.
SELECT roomName, (select reservations.checkIn) as checkin, (select reservations.checkOut) as checkout
FROM rooms
INNER JOIN reservations ON rooms.RoomCode = reservations.Room
WHERE reservations.CheckIn <= '2010-02-06' AND reservations.CheckOut > '2010-02-06' 
ORDER BY roomName;


USE `INN`;
-- INN-4
-- For each stay by GRANT KNERIEN in the hotel, calculate the total amount of money, he paid. Report reservation code, room name (full), checkin and checkout dates, and the total stay cost. Sort output in chronological order by the day of arrival.

SELECT reservations.Code, roomName,(select reservations.checkIn) as checkin, (select reservations.checkOut) as checkout, (select reservations.rate * DATEDIFF(reservations.checkOut, reservations.CheckIn)) as PAID
FROM rooms
INNER JOIN reservations ON rooms.RoomCode = reservations.Room
WHERE reservations.FirstName = 'GRANT' AND reservations.LastName = 'KNERIEN'
ORDER BY reservations.checkIn ASC;


USE `INN`;
-- INN-5
-- For each reservation that starts on December 31, 2010 report the room name, nightly rate, number of nights spent and the total amount of money paid. Sort output in descending order by the number of nights stayed.
SELECT roomName, reservations.Rate, (select DATEDIFF(reservations.checkOut, reservations.CheckIn)) as Nights, (select reservations.rate * DATEDIFF(reservations.checkOut, reservations.CheckIn)) as Money
FROM rooms
INNER JOIN reservations ON rooms.RoomCode = reservations.Room
WHERE reservations.checkIn = '2010-12-31'
ORDER BY DATEDIFF(reservations.checkOut, reservations.CheckIn) DESC;


USE `INN`;
-- INN-6
-- Report all reservations in rooms with double beds that contained four adults. For each reservation report its code, the room abbreviation, full name of the room, check-in and check out dates. Report reservations in chronological order, then sorted by the three-letter room code (in alphabetical order) for any reservations that began on the same day.
SELECT reservations.Code, rooms.RoomCode, roomName, reservations.checkIn, reservations.checkOut 
FROM rooms
INNER JOIN reservations ON rooms.RoomCode = reservations.Room
WHERE bedType = 'Double' and Adults = 4
ORDER BY reservations.checkIn, rooms.RoomCode;


USE `MARATHON`;
-- MARATHON-1
-- Report the overall place, running time, and pace of TEDDY BRASEL.
SELECT Place, RunTime, Pace
FROM marathon
WHERE LastName = 'BRASEL' and FirstName = 'TEDDY'
ORDER BY Place;


USE `MARATHON`;
-- MARATHON-2
-- Report names (first, last), overall place, running time, as well as place within gender-age group for all female runners from QUNICY, MA. Sort output by overall place in the race.
SELECT FirstName, LastName, Place, RunTime, GroupPlace
FROM marathon
WHERE Sex = 'F' and State = 'MA'and Town = 'QUNICY'
ORDER BY Place;


USE `MARATHON`;
-- MARATHON-3
-- Find the results for all 34-year old female runners from Connecticut (CT). For each runner, output name (first, last), town and the running time. Sort by time.
SELECT FirstName, LastName, Town, RunTime
FROM marathon
WHERE Sex = 'F' and Age = 34 and State = 'CT'
ORDER BY RunTime;


USE `MARATHON`;
-- MARATHON-4
-- Find all duplicate bibs in the race. Report just the bib numbers. Sort in ascending order of the bib number. Each duplicate bib number must be reported exactly once.
SELECT DISTINCT race1.BibNumber 
FROM marathon AS race1
    INNER JOIN marathon AS race2 on race1.BibNumber = race2.BibNumber
WHERE race1.FirstName != race2.FirstName
ORDER BY BibNumber;


USE `MARATHON`;
-- MARATHON-5
-- List all runners who took first place and second place in their respective age/gender groups. List gender, age group, name (first, last) and age for both the winner and the runner up (in a single row). Include only age/gender groups with both a first and second place runner. Order the output by gender, then by age group.
SELECT winner.sex, winner.agegroup, winner.firstname, winner.lastname, winner.age, runnerUp.firstname, runnerUp.lastname, runnerUp.age
FROM marathon as winner, marathon as runnerUp
WHERE (winner.groupplace = 1 and runnerUp.groupplace = 2) and (winner.agegroup = runnerUp.agegroup) and (winner.sex = runnerUp.sex)
ORDER By winner.sex, winner.agegroup;


USE `AIRLINES`;
-- AIRLINES-1
-- Find all airlines that have at least one flight out of AXX airport. Report the full name and the abbreviation of each airline. Report each name only once. Sort the airlines in alphabetical order.
SELECT DISTINCT Name, Abbr
FROM airlines
INNER JOIN flights ON airlines.Id = flights.Airline
WHERE Source = 'AXX'
ORDER BY Name;


USE `AIRLINES`;
-- AIRLINES-2
-- Find all destinations served from the AXX airport by Northwest. Re- port flight number, airport code and the full name of the airport. Sort in ascending order by flight number.

SELECT flights.FlightNo, airports.code, airports.name
FROM airports
INNER JOIN flights ON flights.Destination = airports.code
INNER JOIN airlines ON airlines.Id = flights.Airline
WHERE flights.Source = 'AXX' and airlines.Abbr = 'Northwest'
ORDER BY FlightNo;


USE `AIRLINES`;
-- AIRLINES-3
-- Find all *other* destinations that are accessible from AXX on only Northwest flights with exactly one change-over. Report pairs of flight numbers, airport codes for the final destinations, and full names of the airports sorted in alphabetical order by the airport code.
SELECT flight1.flightNo, flight2.flightNo, flight2.Destination, airports.Name 
    FROM airports 
        INNER JOIN airlines 
        INNER JOIN flights AS flight1 ON flight1.airline = airlines.Id 
        INNER JOIN flights AS flight2 ON flight2.airline = flight1.airline  
WHERE flight1.Source = 'AXX' AND flight2.Destination != flight1.Source AND airports.Code = flight2.Destination AND airlines.Name = 'Northwest Airlines' AND flight1.Destination = flight2.Source;


USE `AIRLINES`;
-- AIRLINES-4
-- Report all pairs of airports served by both Frontier and JetBlue. Each airport pair must be reported exactly once (if a pair X,Y is reported, then a pair Y,X is redundant and should not be reported).
SELECT DISTINCT flight1.Source, flight2.Destination
FROM flights AS flight1
INNER JOIN flights as flight2 ON flight2.Source = flight1.Source AND flight2.Destination = flight1.Destination 
INNER JOIN airports ON airports.code = flight1.Source AND airports.code = flight2.Source
INNER JOIN airlines AS airline1 ON airline1.Id = flight1.airline
INNER JOIN airlines AS airline2 ON airline2.Id = flight2.airline
WHERE airline1.Abbr = 'Frontier' and airline2.Abbr = 'JetBlue' AND flight1.Destination > flight1.Source;


USE `AIRLINES`;
-- AIRLINES-5
-- Find all airports served by ALL five of the airlines listed below: Delta, Frontier, USAir, UAL and Southwest. Report just the airport codes, sorted in alphabetical order.
SELECT DISTINCT flight1.source
FROM flights as flight1
    INNER JOIN flights AS flight2 ON flight1.Source = flight2.Source
    INNER JOIN flights AS flight3 ON flight1.Source = flight3.Source
    INNER JOIN flights AS flight4 ON flight1.Source = flight4.Source
    INNER JOIN flights AS flight5 ON flight1.Source = flight5.Source
    INNER JOIN airlines AS airline1 ON flight1.Airline = airline1.Id
    INNER JOIN airlines AS airline2 ON flight2.Airline = airline2.Id
    INNER JOIN airlines AS airline3 ON flight3.Airline = airline3.Id
    INNER JOIN airlines AS airline4 ON flight4.Airline = airline4.Id
    INNER JOIN airlines AS airline5 ON flight5.Airline = airline5.Id
WHERE airline1.Abbr = 'Delta' AND airline2.Abbr = 'Frontier' AND airline3.Abbr='USAir' AND airline4.Abbr='UAL' AND airline5.Abbr='Southwest' 
ORDER BY flight1.source ASC;


USE `AIRLINES`;
-- AIRLINES-6
-- Find all airports that are served by at least three Southwest flights. Report just the three-letter codes of the airports — each code exactly once, in alphabetical order.
SELECT DISTINCT flight1.Source 
FROM flights AS flight1
INNER JOIN flights AS flight2 ON flight1.Source = flight2.Source
INNER JOIN flights As flight3 ON flight1.Source = flight3.Source
INNER JOIN airlines ON flight1.Airline = airlines.Id AND flight2.Airline= airlines.Id and flight3.Airline= airlines.Id
WHERE airlines.Abbr = 'Southwest' AND flight1.FlightNo != flight2.FlightNo AND flight1.FlightNo != flight3.FlightNo AND flight2.FlightNo != flight3.FlightNo
ORDER BY flight1.Source ASC;


USE `KATZENJAMMER`;
-- KATZENJAMMER-1
-- Report, in order, the tracklist for ’Le Pop’. Output just the names of the songs in the order in which they occur on the album.
select Songs.Title
from Albums
inner join Tracklists on Tracklists.Album = Albums.AId
inner join Songs on Songs.SongId= Tracklists.Song
WHERE Albums.Title = "Le Pop";


USE `KATZENJAMMER`;
-- KATZENJAMMER-2
-- List the instruments each performer plays on ’Mother Superior’. Output the first name of each performer and the instrument, sort alphabetically by the first name.
SELECT FirstName, Instrument
FROM Instruments
INNER JOIN Band ON Band.Id = Instruments.Bandmate
INNER JOIN Performance ON Band.Id = Performance.Bandmate
INNER JOIN Songs ON Songs.SongId = Performance.Song and Instruments.Song = Songs.SongId
WHERE Songs.Title = 'Mother Superior'
ORDER BY FirstName, Instrument;


USE `KATZENJAMMER`;
-- KATZENJAMMER-3
-- List all instruments played by Anne-Marit at least once during the performances. Report the instruments in alphabetical order (each instrument needs to be reported exactly once).
SELECT DISTINCT Instrument
FROM Instruments
INNER JOIN Band ON Band.Id = Instruments.Bandmate
INNER JOIN Performance ON Band.Id = Performance.Bandmate
INNER JOIN Songs ON Songs.SongId = Performance.Song and Instruments.Song = Songs.SongId
WHERE FirstName = "Anne-Marit"
ORDER BY Instrument;


USE `KATZENJAMMER`;
-- KATZENJAMMER-4
-- Find all songs that featured ukalele playing (by any of the performers). Report song titles in alphabetical order.
SELECT DISTINCT Songs.Title 
FROM Songs
INNER JOIN Performance ON Songs.SongId = Performance.Song
INNER JOIN Band ON Band.Id = Performance.Bandmate
INNER JOIN Instruments ON Band.Id = Instruments.Bandmate and Instruments.Song = Songs.SongId
WHERE Instrument = 'Ukalele'
ORDER BY Songs.Title;


USE `KATZENJAMMER`;
-- KATZENJAMMER-5
-- Find all instruments Turid ever played on the songs where she sang lead vocals. Report the names of instruments in alphabetical order (each instrument needs to be reported exactly once).
SELECT DISTINCT Instrument
FROM Instruments
INNER JOIN Band ON Band.Id = Instruments.Bandmate
INNER JOIN Performance ON Band.Id = Performance.Bandmate
INNER JOIN Songs ON Songs.SongId = Performance.Song and Instruments.Song = Songs.SongId
INNER JOIN Vocals ON Songs.SongId = Vocals.Song and Vocals.Bandmate = Band.Id
WHERE FirstName = 'Turid' and Vocals.VocalType = 'Lead'
ORDER BY Instrument;


USE `KATZENJAMMER`;
-- KATZENJAMMER-6
-- Find all songs where the lead vocalist is not positioned center stage. For each song, report the name, the name of the lead vocalist (first name) and her position on the stage. Output results in alphabetical order by the song, then name of band member. (Note: if a song had more than one lead vocalist, you may see multiple rows returned for that song. This is the expected behavior).
SELECT Songs.Title, Band.FirstName, StagePosition
FROM Performance
    INNER JOIN Songs ON Performance.Song = Songs.SongId
    INNER JOIN Vocals ON Performance.Song = Vocals.Song AND Vocals.Bandmate = Performance.Bandmate 
    INNER JOIN Band ON Band.Id = Vocals.Bandmate
WHERE Vocals.VocalType = 'lead' AND StagePosition != 'center'
ORDER BY Songs.Title, Band.FirstName;


USE `KATZENJAMMER`;
-- KATZENJAMMER-7
-- Find a song on which Anne-Marit played three different instruments. Report the name of the song. (The name of the song shall be reported exactly once)
SELECT DISTINCT Songs.Title 
FROM Songs
    INNER JOIN Instruments AS instrument1 ON Songs.SongId = instrument1.Song
    INNER JOIN Instruments AS instrument2 ON Songs.SongId = instrument2.Song
    INNER JOIN Instruments AS instrument3 ON Songs.SongId = instrument3.Song
    INNER JOIN Band ON instrument1.Bandmate = Band.Id AND instrument2.Bandmate = Band.Id AND instrument3.Bandmate = Band.Id
WHERE Band.Firstname = 'Anne-Marit' AND instrument1.Instrument != instrument2.Instrument AND instrument1.Instrument != instrument3.Instrument AND instrument2.Instrument != instrument3.Instrument;


USE `KATZENJAMMER`;
-- KATZENJAMMER-8
-- Report the positioning of the band during ’A Bar In Amsterdam’. (just one record needs to be returned with four columns (right, center, back, left) containing the first names of the performers who were staged at the specific positions during the song).
SELECT b1.Firstname AS 'RIGHT', b2.Firstname AS 'CENTER', b3.Firstname AS 'BACK', b4.Firstname AS 'LEFT'
FROM Songs
    INNER JOIN Performance AS p1 ON Songs.SongId = p1.Song
    INNER JOIN Performance AS p2 ON Songs.SongId = p2.Song
    INNER JOIN Performance AS p3 ON Songs.SongId = p3.Song
    INNER JOIN Performance AS p4 ON Songs.SongId = p4.Song
    INNER JOIN Band AS b1 ON b1.Id = p1.Bandmate
    INNER JOIN Band AS b2 ON b2.Id = p2.Bandmate
    INNER JOIN Band AS b3 ON b3.Id = p3.Bandmate
    INNER JOIN Band AS b4 ON b4.Id = p4.Bandmate
WHERE Songs.Title='A Bar In Amsterdam' AND p1.StagePosition = 'right' AND p2.StagePosition = 'center' AND p3.StagePosition = 'back' AND p4.StagePosition = 'left';


