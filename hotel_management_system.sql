-- Removing older schema if exists
DROP SCHEMA IF EXISTS sl_hotels CASCADE;

-- Create new schema
CREATE SCHEMA IF NOT EXISTS sl_hotels;

-- Creating table - [Reservations]
DROP TABLE IF EXISTS sl_hotels.Reservations;
CREATE TABLE IF NOT EXISTS sl_hotels.Reservations (
    ReservationID SERIAL PRIMARY KEY,
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
    
    FOREIGN KEY (HotelID) REFERENCES sl_hotels.Hotels(HotelID),
    FOREIGN KEY (GuestID) REFERENCES sl_hotels.Guests(GuestID),
    FOREIGN KEY (RoomID) REFERENCES sl_hotels.Rooms(RoomID),
    FOREIGN KEY (PaymentID) REFERENCES sl_hotels.Payments(PaymentID),
    FOREIGN KEY (EmployeeID) REFERENCES sl_hotels.Employee(EmployeeID),
    FOREIGN KEY (RoomServiceID) REFERENCES sl_hotels.RoomService(ServiceID)
);

-- Creating table - [Payments]
DROP TABLE IF EXISTS sl_hotels.Payments;
CREATE TABLE IF NOT EXISTS sl_hotels.Payments (
    PaymentID SERIAL PRIMARY KEY,
    ReservationID INT NOT NULL,
    PaymentAmount DECIMAL(10, 2) NOT NULL,
    PaymentDate DATE NOT NULL,
    PaymentTime TIME NOT NULL,
    PaymentMethodID INT NOT NULL,
    PaidInAdvance BOOLEAN NOT NULL,
    Tips INT,

    FOREIGN KEY (ReservationID) REFERENCES sl_hotels.Reservations(ReservationID),
    FOREIGN KEY (PaymentMethodID) REFERENCES sl_hotels.PaymentMethod(MethodID)
);

-- Creating table - [Hotels]
DROP TABLE IF EXISTS sl_hotels.Hotels;
CREATE TABLE IF NOT EXISTS sl_hotels.Hotels (
    HotelID SERIAL PRIMARY KEY,
    Hotel_Name VARCHAR(100) NOT NULL,
    Hotel_Address VARCHAR(100) NOT NULL,
    ContactNumber VARCHAR(20) NOT NULL,
    Email VARCHAR(100) NOT NULL,
    HasPool BOOLEAN NOT NULL,
    HasPenthouse BOOLEAN NOT NULL,
    HasConferenceRoom BOOLEAN NOT NULL,
    HasOpenRoof BOOLEAN NOT NULL,
    HasGamesArea BOOLEAN NOT NULL,
    IsFiveStar BOOLEAN NOT NULL
);

-- Creating table - [Guests]
DROP TABLE IF EXISTS sl_hotels.Guests;
CREATE TABLE IF NOT EXISTS sl_hotels.Guests (
    GuestID SERIAL PRIMARY KEY,
    Guest_Name VARCHAR(100) NOT NULL,
    Email VARCHAR(100) NOT NULL,
    Phone VARCHAR(20) NOT NULL,
    Nationality VARCHAR(50) NOT NULL,
    Age INT NOT NULL,
    CheckInDate DATE NOT NULL,
    CheckOutDate DATE NOT NULL,
    CheckInTime TIME NOT NULL,
    CheckOutTime TIME NOT NULL,
    IsMember BOOLEAN NOT NULL,
    IsVIP BOOLEAN NOT NULL,
    IsNew BOOLEAN NOT NULL
);

-- Creating table - [Rooms]
DROP TABLE IF EXISTS sl_hotels.Rooms;
CREATE TABLE IF NOT EXISTS sl_hotels.Rooms (
    RoomID SERIAL PRIMARY KEY,
    HotelID INT NOT NULL,
    Description VARCHAR(50) NOT NULL,
    Beds INT NOT NULL,
    Baths INT NOT NULL,
    Rate DECIMAL(10, 2) NOT NULL,
    HasOceanView BOOLEAN NOT NULL,
    HasMountainView BOOLEAN NOT NULL,
    IsPenthouse BOOLEAN NOT NULL,
    
    FOREIGN KEY (HotelID) REFERENCES sl_hotels.Hotels(HotelID)
);

-- Creating table - [RoomService]
DROP TABLE IF EXISTS sl_hotels.RoomService;
CREATE TABLE IF NOT EXISTS sl_hotels.RoomService (
    ServiceID SERIAL PRIMARY KEY,
    Description VARCHAR(255) NOT NULL,
    Meals INT NOT NULL,
    Laundry INT NOT NULL,
    Cleaning INT NOT NULL
);

-- Creating table - [PaymentMethod]
DROP TABLE IF EXISTS sl_hotels.PaymentMethod;
CREATE TABLE IF NOT EXISTS sl_hotels.PaymentMethod (
    MethodID SERIAL PRIMARY KEY,
    Method VARCHAR(30) NOT NULL,
    TotalSuccess INT NOT NULL,
    TotalFailure INT NOT NULL
);

-- Creating table - [Employee]
DROP TABLE IF EXISTS sl_hotels.Employee;
CREATE TABLE IF NOT EXISTS sl_hotels.Employee (
    EmployeeID SERIAL PRIMARY KEY,
    Name VARCHAR(50) NOT NULL,
    Contact BIGINT NOT NULL,
    Address VARCHAR(255) NOT NULL,
    TotalBookings INT NOT NULL
);

-- Creating table - [Staff]
DROP TABLE IF EXISTS sl_hotels.Staff;
CREATE TABLE IF NOT EXISTS sl_hotels.Staff (
    StaffID SERIAL PRIMARY KEY,
    Name VARCHAR(50) NOT NULL,
    Contact BIGINT NOT NULL,
    Address VARCHAR(255) NOT NULL,
    TotalServices INT NOT NULL
);

-- Creating table - [Maintenance]
DROP TABLE IF EXISTS sl_hotels.Maintenance;
CREATE TABLE IF NOT EXISTS sl_hotels.Maintenance(
    MaintenanceID SERIAL PRIMARY KEY,
    StaffID INT NOT NULL,
    RoomID INT NOT NULL,
    HotelID INT NOT NULL,

    FOREIGN KEY (StaffID) REFERENCES sl_hotels.Staff(StaffID),
    FOREIGN KEY (RoomID) REFERENCES sl_hotels.Rooms(RoomID),
    FOREIGN KEY (HotelID) REFERENCES sl_hotels.Hotels(HotelID)
);