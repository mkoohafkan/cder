# vignette queries work

    Code
      cdec_query(stations, sensors, duration, start.date, end.date)
    Output
      # A tibble: 388 x 9
         Stati~1 Durat~2 Senso~3 Senso~4 DateTime            ObsDate             Value
         <chr>   <chr>     <int> <chr>   <dttm>              <dttm>              <dbl>
       1 NSL     H           100 EL COND 2023-01-01 00:00:00 2023-01-01 00:00:00  6015
       2 NSL     H           100 EL COND 2023-01-01 01:00:00 2023-01-01 01:00:00  6283
       3 NSL     H           100 EL COND 2023-01-01 02:00:00 2023-01-01 02:00:00  6425
       4 NSL     H           100 EL COND 2023-01-01 03:00:00 2023-01-01 03:00:00  6471
       5 NSL     H           100 EL COND 2023-01-01 04:00:00 2023-01-01 04:00:00  6230
       6 NSL     H           100 EL COND 2023-01-01 05:00:00 2023-01-01 05:00:00  5925
       7 NSL     H           100 EL COND 2023-01-01 06:00:00 2023-01-01 06:00:00  4668
       8 NSL     H           100 EL COND 2023-01-01 07:00:00 2023-01-01 07:00:00  3991
       9 NSL     H           100 EL COND 2023-01-01 08:00:00 2023-01-01 08:00:00  3700
      10 NSL     H           100 EL COND 2023-01-01 09:00:00 2023-01-01 09:00:00  4757
      # ... with 378 more rows, 2 more variables: DataFlag <chr>, SensorUnits <chr>,
      #   and abbreviated variable names 1: StationID, 2: Duration, 3: SensorNumber,
      #   4: SensorType

