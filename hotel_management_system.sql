-- Removing older schema if exists
DROP SCHEMA IF EXISTS sl_hotels;

-- Create new schema
CREATE SCHEMA IF NOT EXISTS sl_hotels;

-- Creating table - [Reservations]
DROP TABLE IF EXISTS sl_hotels.Reservations;
CREATE TABLE IF NOT EXISTS sl_hotels.Reservations (
    ReservationID INT PRIMARY KEY NOT NULL,
    HotelID INT NOT NULL,
    GuestID INT NOT NULL,
    RoomID INT NOT NULL,
    PaymentID BIGINT NOT NULL,
    EmployeeID INT NOT NULL,
    RoomServiceID INT NOT NULL,
    CheckInDate DATE NOT NULL,
    CheckOutDate DATE NOT NULL,
    CheckInTime TIME NOT NULL,
    CheckOutTime TIME NOT NULL,
    StayDuration INT NOT NULL,
    TotalAmount DECIMAL(10, 2) NOT NULL,
    IsConfirmed BIT NOT NULL,
    
    FOREIGN KEY (HotelID) REFERENCES sl_hotels.Hotels(HotelID),
    FOREIGN KEY (GuestID) REFERENCES sl_hotels.Guests(GuestID),
    FOREIGN KEY (RoomID) REFERENCES sl_hotels.Rooms(RoomID),
    FOREIGN KEY (PaymentID) REFERENCES sl_hotels.Payment(PaymentID),
    FOREIGN KEY (EmployeeID) REFERENCES sl_hotels.Employee(EmployeeID),
    FOREIGN KEY (RoomServiceID) REFERENCES sl_hotels.RoomService(RoomServiceID),
);

-- Creating table - [Payments]
DROP TABLE IF EXISTS sl_hotels.Payments;
CREATE TABLE IF NOT EXISTS sl_hotels.Payments (
    PaymentID INT PRIMARY KEY NOT NULL,
    PaymentAmount DECIMAL(10, 2) NOT NULL,
    PaymentDate DATE NOT NULL,
    PaymentTime TIME NOT NULL,
    PaymentMethodID VARCHAR(50) NOT NULL,
    AdvancePayment BIT NOT NULL,
    Tips INT,

    FOREIGN KEY (ReservationID) REFERENCES sl_hotels.Reservations(ReservationID)
    FOREIGN KEY (PaymentMethodID) REFERENCES sl_hotels.Payment_Method(PaymentMethodID)
);

-- Creating table - [Hotels]
DROP TABLE IF EXISTS sl_hotels.Hotels;
CREATE TABLE IF NOT EXISTS sl_hotels.Hotels (
    HotelID INT PRIMARY KEY NOT NULL,
    Hotel_Name VARCHAR(100) NOT NULL,
    Hotel_Address VARCHAR(100) NOT NULL,
    ContactNumber VARCHAR(20) NOT NULL,
    Email VARCHAR(100) NOT NULL
    HasPool BIT NOT NULL,
    HasPenthouse BIT NOT NULL,
    HasConferenceRoom BIT NOT NULL,
    HasOpenRoof BIT NOT NULL,
    HasGamesArea BIT NOT NULL,
    IsFiveStar BIT NOT NULL,
);

-- Creating table - [Guests]
DROP TABLE IF EXISTS sl_hotels.Guests;
CREATE TABLE IF NOT EXISTS sl_hotels.Guests (
    GuestID INT PRIMARY KEY ,
    Guest_Name VARCHAR(100) NOT NULL,
    Email VARCHAR(100) NOT NULL,
    Phone VARCHAR(20) NOT NULL,
    Nationality VARCHAR(50) NOT NULL,
    Age INT NOT NULL,
    CheckInDate DATE NOT NULL,
    CheckOutDate DATE NOT NULL,
    CheckInTime TIME NOT NULL,
    CheckOutTime TIME NOT NULL,
    IsMember BIT NOT NULL,
    IsVIP BIT NOT NULL
);

-- Creating table - [Rooms]
DROP TABLE IF EXISTS sl_hotels.Rooms;
CREATE TABLE IF NOT EXISTS sl_hotels.Rooms (
    RoomID INT PRIMARY KEY,
    HotelID INT NOT NULL NOT NULL,
    RoomType VARCHAR(50) NOT NULL,
    Beds INT NOT NULL,
    Baths INT NOT NULL,
    Rate DECIMAL(10, 2) NOT NULL,
    IsOccupied BIT NOT NULL,
    HasOceanView BIT NOT NULL,
    HasMountainView BIT NOT NULL,
    IsPenthouse BIT NOT NULL,
    LastOccupiedDate DATE,
    LastCleanedDate DATE,
    
    FOREIGN KEY (HotelID) REFERENCES sl_hotels.Hotels(HotelID)
);