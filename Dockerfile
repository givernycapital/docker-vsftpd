FROM alpine:3.9

RUN apk --update --no-cache add vsftpd openssl

RUN adduser -D -u 1000 files

COPY docker-entrypoint.sh /

# A fixed server certificate for the hostname ftps, signed by a test-only CA whose
# private key was discarded after signing. giverny-platform's FTPES tests verify
# the server against certs/test-ca.pem. The entrypoint generates a self-signed
# certificate only when this file is absent. Test use only: the key is public.
COPY certs/vsftpd.pem /etc/vsftpd/vsftpd.pem

EXPOSE 21 20000

CMD /docker-entrypoint.sh
