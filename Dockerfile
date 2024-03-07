FROM ubuntu:22.04

# installing dependencies for running a python application
RUN apt-get update && apt-get install -y python3 python3-pip postgresql-client libpq-dev

# install pipenv
RUN pip3 install poetry

# setting the working directory
WORKDIR /app

# install pipenv dependencies
COPY pyproject.toml ./
RUN poetry install --no-root

# copying our application into the container
COPY todo todo

# running our application
CMD ["poetry", "run", "flask", "--app", "todo", "run", "--host", "0.0.0.0", "--port", "6400"]

# Adding a delay to our application startup
CMD ["bash", "-c", "sleep 10 && poetry run flask --app todo run --host 0.0.0.0 --port 6400"]
