FROM python:3.9-slim-buster

ENV DATABASE_URL postgres://postgres:1234@organizedproject-db-1:5432/EmployeeDB

WORKDIR /app/

COPY requirements.txt /app/

RUN pip install --trusted-host pypi.python.org -r requirements.txt

RUN pip install dj_database_url

COPY employee_project /app/employee_project

EXPOSE 8000

ENV NAME employee_registration

WORKDIR /app/employee_project

#starts the django server
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]

#Migrates the database
CMD ["python", "manage.py", "migrate"]

CMD ["python", "manage.py", "makemigrations"]