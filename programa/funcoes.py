import datetime

def checkDate(date):
    if isinstance(date, str):
        date = date.split("-")
        try:
            datetime.datetime(int(date[0]), int(date[1]), int(date[2]))
            print("valid date")
        except ValueError:
            raise
    else:
        raise

checkDate("2023-05-04")