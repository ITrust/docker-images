FROM python:2.7

ARG elastalert_release="v0.1.16"
ARG elastalert_systemuser="elastalert"
ARG elastalert_rules_folder="/opt/rules"
ARG elastert_installation_path="/opt/elastalert"

ENV ELASTALERT_INSTALLATION_PATH="${elastert_installation_path}" \
    ELASTALERT_RULES_FOLDER="${elastalert_rules_folder}"

RUN apt-get update && apt-get install -y libffi-dev libssl-dev && \
    mkdir -p "${elastert_installation_path}" && \
    useradd -d "${elastert_installation_path}" -r "${elastalert_systemuser}" && \
    chown -R "${elastalert_systemuser}":"${elastalert_systemuser}" "${elastert_installation_path}"

WORKDIR ${elastert_installation_path}

COPY ./entrypoint.sh .

RUN chmod u+x ./entrypoint.sh && \
    chown "${elastalert_systemuser}":"${elastalert_systemuser}" ./entrypoint.sh

USER ${elastalert_systemuser}

RUN curl -L "https://github.com/Yelp/elastalert/archive/${elastalert_release}.tar.gz" | tar -xz -C "${elastert_installation_path}" --strip-components=1 && \
    pip install --user "elasticsearch<3.0.0" && \
    python setup.py install --user

VOLUME ["${elastalert_rules_folder}", "${elastert_installation_path}/elastalert_modules"]

ENTRYPOINT ["./entrypoint.sh"]

CMD ["--verbose"]
