# The first instruction is what image we want to base our container on
# We Use an official Python runtime as a parent image
FROM python:3.6

# The enviroment variable ensures that the python output is set straight
# to the terminal with out buffering it first
ENV PYTHONUNBUFFERED 1

# create root directory for our project in the container
RUN mkdir /newsletter_with_frontend

# Set the working directory to /newsletter_with_frontend
WORKDIR /newsletter_with_frontend

# Copy the current directory contents into the container at /newsletter_with_frontend
COPY . /newsletter_with_frontend/

# Install any needed packages specified in requirements.txt
RUN pip install -r requirements.txt

# collect static files
RUN python manage.py collectstatic --noinput

# run waitress
CMD gunicorn newsletter_test.wsgi:application --bind 0.0.0.0:$PORT