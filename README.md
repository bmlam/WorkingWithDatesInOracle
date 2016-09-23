# WorkingWithDatesInOracle
Miscellaneous exploits of Oracle's powerful date functions

For those who need to submit a timesheet in the form of a spreadsheet which should contain the days of the month and the corresponding calender weeks number, like the one shown in 

TimeSheetDayAndWeek.PNG

there is a minor challenge to fill in the correct week number correctly. ISO8601 has a definition how the weeks are numbered. The query in 

fill_timesheet_days.sql

solves the problem. It also comes with a handy feature of leaving the saturdays and sundays as blanks, clearly marking the week boundaries.

