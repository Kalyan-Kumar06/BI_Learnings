Calendar = 
VAR FiscalPeriod = 4 //Here financial year starts from April to March 
RETURN
    ADDCOLUMNS (
        CALENDAR ( MIN ( 'Sales Data'[OrderDate] ), TODAY() ), // Min date here sales data [Order Date] - take your report date
        "Date Key", FORMAT ( [Date], "YYYYMMDD" ),
        "Year", YEAR ( [Date] ),
        "Month Key", FORMAT ( [Date], "MM" ),
        "Month Name Short", FORMAT ( [Date], "MMM" ),
        "Month Name Long", FORMAT ( [Date], "mmmm" ),
        "Year Month", FORMAT ( [Date], "Mmm-yy" ),
        "Year Month Key", FORMAT ( [Date], "YYYYMM" ),
        "Quarter", "Q" & FORMAT ( [Date], "Q" ),
        "Year Quarter",
            "Q" & FORMAT ( [Date], "Q" ) & "-" 
                & FORMAT ( [Date], "YY" ),
        "Year Quarter Key",
            YEAR ( [Date] ) & "Q"
                & FORMAT ( [Date], "Q" ),
        "Year Current", IF ( YEAR ( [Date] ) = YEAR ( TODAY () ), "Current", FORMAT ( [Date], "YYYY" ) ),
        "Is YTD", IF ( YEAR ( [Date] ) = YEAR ( TODAY () ), "Yes", "No" ),
        "Year Month Current",
        IF (
            YEAR ( [Date] ) = YEAR ( TODAY () ) 
                && MONTH ( [Date] ) = MONTH ( TODAY () ),
            "Current",
            FORMAT ( [Date], "mmm-yy" )
        ),
        "Year Quarter Current",
        IF (
            YEAR ( [Date] ) = YEAR ( TODAY () ) 
                && FORMAT ( [Date], "Q" ) = FORMAT ( TODAY (), "Q" ),
            "Current",
            "Q" & FORMAT ( [Date], "Q" ) & "-" 
                & FORMAT ( [Date], "YY" )
        ),
        "WeekNum", WEEKNUM ( [Date] ),
        "Weekday", WEEKDAY ( [Date],2 ),
        "Weekname", FORMAT ( [Date], "dddd" ),
        "FY",
            "FY" & IF ( MONTH ( [Date] ) >= FiscalPeriod, YEAR ( [Date] ) + 1, YEAR ( [Date] ) ),
        "FP",
        IF (
            MONTH ( [Date] ) >= FiscalPeriod,
            MONTH ( [Date] ) - FiscalPeriod + 1,
            MONTH ( [Date] ) + ( 12 - FiscalPeriod + 1 )
        ),
        "FQ",
        "FQ" & ROUNDUP (
            IF (
                MONTH ( [Date] ) >= FiscalPeriod,
                MONTH ( [Date] ) - FiscalPeriod + 1,
                MONTH ( [Date] ) + ( 12 - FiscalPeriod + 1 )
            ) / 3, 0
        )
    )
