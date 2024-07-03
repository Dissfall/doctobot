FROM drakkarsoftware/octobot:1.0.10

WORKDIR /octobot

RUN Octobot tentacles --install --all

VOLUME /octobot/backtesting
VOLUME /octobot/logs
VOLUME /octobot/tentacles
VOLUME /octobot/user

EXPOSE 5001

HEALTHCHECK --interval=15s --timeout=10s --retries=5 CMD curl -sS http://127.0.0.1:5001 || exit 1

ENTRYPOINT ["./docker-entrypoint.sh"]
