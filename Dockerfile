FROM python:3.6.9

RUN apt-get update && apt-get install -y --no-install-recommends make \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Install Pipenv
# --------------
# https://pip.pypa.io/en/stable/user_guide/#configuration
ARG PIP_NO_CACHE_DIR=0
ARG PIPENV_VERSION="2018.10.13"
RUN pip install pipenv==$PIPENV_VERSION

WORKDIR /app
COPY . .

ENV PYTHONUNBUFFERED=1
ENV PIPENV_VENV_IN_PROJECT=1
RUN pipenv --python=3.6.9 --site-packages
RUN pipenv install --deploy 

# Expose ports
# ------------
EXPOSE 5001

# Set the default command
# -----------------------
ENTRYPOINT ["make"]
CMD ["serve-gunicorn"]
