FROM python:2.7

ARG elastalert_release="v0.1.25"
ARG elastalert_rules_folder="/opt/rules"
ARG elastert_installation_path="/opt/elastalert"
ARG elasticsearch_version=">=5.0.0"

ENV ELASTALERT_INSTALLATION_PATH="${elastert_installation_path}" \
    ELASTALERT_RULES_FOLDER="${elastalert_rules_folder}"

RUN apt-get update \
 && apt-get install -y \
        libffi-dev \
        libssl-dev \
        libmagic-dev \
 && mkdir -p "${elastert_installation_path}" \
 && curl -L "https://github.com/Yelp/elastalert/archive/${elastalert_release}.tar.gz" | tar -xz -C "${elastert_installation_path}" --strip-components=1 \
 && pip install --no-cache "elasticsearch${elasticsearch_version}" \
 && pip install --no-cache "future" \
 && pip install --no-cache "python-magic" \
 && python "${elastert_installation_path}/setup.py" install

WORKDIR ${elastert_installation_path}

COPY ./entrypoint.sh .

RUN chmod +x "./entrypoint.sh"

VOLUME ["${elastalert_rules_folder}", "./elastalert_modules"]

ENTRYPOINT ["./entrypoint.sh"]

CMD ["--verbose"]
