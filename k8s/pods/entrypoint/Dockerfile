FROM alpine
WORKDIR /etc/lolz
ADD ./l.txt .
RUN apk add bash
ENTRYPOINT [ "tail" ]
CMD [ "-f", "/dev/null" ]
