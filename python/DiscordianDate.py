#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Sun Jan 28 19:12:04 2018

@author: grobe0ba

$Id: DiscordianDate.py,v 1.5 2019/02/16 17:20:15 grobe0ba Exp $
"""

from argparse import ArgumentParser
from datetime import date


class DiscordianDate:
    """
        This class is to generate the official Discordian date.
    """
    def __init__(self, dt):
        self.dt = dt

        self.dayNames = ["Sweetmorn", "Boomtime", "Pungenday",
                         "Prickle-Prickle", "Setting Orange"]
        self.monthNames = ["Chaos", "Discord", "Confusion", "Bureaucracy",
                           "The Aftermath"]
        self.shortMonthNames = ["Ch", "Dsc", "Cfn", "Bcy", "Afm"]

        self.dyear = self.dt.year + 1166
        self.ddayOfMonth = self.dt.day
        if self.dt.month == 1:
            # January
            self.dmonthOfYear = 0
        elif self.dt.month == 2:
            # February
            if self.dt.day == 29:
                self.dmonthOfYear = -1
                self.ddayOfMonth = -1
            else:
                self.dmonthOfYear = 0
                self.ddayOfMonth += 31
        elif self.dt.month == 3:
            # March
            self.ddayOfMonth += 59
            if self.ddayOfMonth <= 73:
                self.dmonthOfYear = 0
            else:
                self.ddayOfMonth -= 73
                self.dmonthOfYear = 1
        elif self.dt.month == 4:
            # April
            self.ddayOfMonth += 17
            self.dmonthOfYear = 1
        elif self.dt.month == 5:
            # May
            self.ddayOfMonth += 47
            if self.ddayOfMonth <= 73:
                self.dmonthOfYear = 1
            else:
                self.ddayOfMonth -= 73
                self.dmonthOfYear = 2
        elif self.dt.month == 6:
            # June
            self.ddayOfMonth += 5
            self.dmonthOfYear = 2
        elif self.dt.month == 7:
            # July
            self.ddayOfMonth += 35
            self.dmonthOfYear = 2
        elif self.dt.month == 8:
            # August
            self.ddayOfMonth += 66
            if self.ddayOfMonth <= 73:
                self.dmonthOfYear = 2
            else:
                self.ddayOfMonth -= 73
                self.dmonthOfYear = 3
        elif self.dt.month == 9:
            # September
            self.ddayOfMonth += 24
            self.dmonthOfYear = 3
        elif self.dt.month == 10:
            # October
            self.ddayOfMonth += 54
            if self.ddayOfMonth <= 73:
                self.dmonthOfYear = 3
            else:
                self.ddayOfMonth -= 73
                self.dmonthOfYear = 4
        elif self.dt.month == 11:
            # November
            self.ddayOfMonth += 12
            self.dmonthOfYear = 4
        elif self.dt.month == 12:
            # December
            self.ddayOfMonth += 42
            self.dmonthOfYear = 4

    def __str__(self):
        offset = 1
        if self.dmonthOfYear == 1:
            if self.ddayOfMonth > 16:
                offset = -2
            else:
                offset = 3
        if self.dmonthOfYear == 2:
            offset = 0
        if self.dmonthOfYear == 3:
            offset = 2
        if self.dmonthOfYear == 4:
            offset = -1
        dayName = self.dayNames[((self.ddayOfMonth - offset) %
                                 len(self.dayNames))]
        monthName = self.monthNames[self.dmonthOfYear % len(self.monthNames)]
        shortMonthName = self.shortMonthNames[self.dmonthOfYear %
                                              len(self.monthNames)]
        return "%s->%d-%d-%d:\t%s, %s %d in the YOLD %d\t%d%s%d" % (
                self.dt.isoformat(),
                self.dyear,
                self.dmonthOfYear+1,
                self.ddayOfMonth,
                dayName,
                monthName,
                self.ddayOfMonth,
                self.dyear,
                self.ddayOfMonth,
                shortMonthName,
                self.dyear)


if __name__ == '__main__':
    optionParser = ArgumentParser()
    optionParser.add_argument("-y", "--year", dest="year", default=None,
                              help="Year")
    optionParser.add_argument("-m", "--month", dest="month", default=None,
                              help="Month of year")
    optionParser.add_argument("-d", "--day", dest="day", default=None,
                              help="Day of month")
    options = optionParser.parse_args()

    dt = date.today()

    year = dt.year
    month = dt.month
    day = dt.day

    if options.year is not None:
        year = int(options.year)
    if options.month is not None:
        month = int(options.month)
    if options.day is not None:
        day = int(options.day)

    dt = date(year, month, day)
    dg = DiscordianDate(dt)
    print(dg)
