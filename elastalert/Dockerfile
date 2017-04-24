FROM python:2.7

ARG elastalert_release="v0.1.12"
ARG elastalert_rules_folder="/opt/rules"
ARG elastert_installation_path="/opt/elastalert"

ENV ELASTALERT_INSTALLATION_PATH="${elastert_installation_path}" \
    ELASTALERT_RULES_FOLDER="${elastalert_rules_folder}"

RUN mkdir -p "${elastert_installation_path}" && \
    curl -L "https://github.com/Yelp/elastalert/archive/${elastalert_release}.tar.gz" | tar -xz -C "${elastert_installation_path}" --strip-components=1

WORKDIR ${elastert_installation_path}

COPY ./entrypoint.sh .

RUN chmod u+x ./entrypoint.sh && \
    pip install "setuptools>=11.3" && \
    pip install "elasticsearch<3.0.0" && \
    pip install -r requirements.txt && \
    pip install "requests==2.2.1" && \
    pip install "cryptography>=1.7" && \
    python setup.py install

VOLUME ["${elastalert_rules_folder}", "${elastert_installation_path}/elastalert_modules"]

ENTRYPOINT ["./entrypoint.sh"]

CMD ["--verbose"]