FROM drakkarsoftware/octobot:0.4.54

WORKDIR /octobot

RUN apt-get update && apt-get install unzip -y

RUN ./OctoBot tentacles --install --all
RUN ./OctoBot tentacles --install --all --location "https://raw.githubusercontent.com/techfreaque/octobot-lorentzian-classification/main/releases/latest/any_platform.zip"
RUN ./OctoBot tentacles --install --all --location "https://raw.githubusercontent.com/techfreaque/octobot-spot-master-3000/main/releases/latest/any_platform.zip"
RUN ./OctoBot tentacles --install --all --location "https://raw.githubusercontent.com/techfreaque/octo-ui-2/main/releases/octo-ui2-latest/any_platform.zip"

RUN mkdir user/profiles/spot_master_3000 \
  && curl -sS https://raw.githubusercontent.com/techfreaque/octobot-spot-master-3000/main/releases/profile/latest/spot_master_3000_profile.zip > user/profiles/spot_master_3000/profile.zip \
  && unzip user/profiles/spot_master_3000/profile.zip -d user/profiles/spot_master_3000 \
  && rm user/profiles/spot_master_3000/profile.zip

RUN mkdir user/profiles/lorentzian-classification \
  && curl -sS https://raw.githubusercontent.com/techfreaque/octobot-lorentzian-classification/main/releases/profile/lorentzian-classification_profile.zip > user/profiles/lorentzian-classification/profile.zip \
  && unzip user/profiles/lorentzian-classification/profile.zip -d user/profiles/lorentzian-classification \
  && rm user/profiles/lorentzian-classification/profile.zip

RUN apt-get clean autoclean \
  && apt-get autoremove --yes \
  && rm -rf /var/lib/{apt,dpkg,cache,log}/

EXPOSE 5001

HEALTHCHECK --interval=15s --timeout=10s --retries=5 CMD curl -sS http://127.0.0.1:5001 || exit 1

ENTRYPOINT ["./docker-entrypoint.sh"]
