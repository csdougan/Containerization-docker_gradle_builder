FROM gradle:latest
COPY runme.sh /runme.sh
USER root
RUN  chmod +x /runme.sh && \
     mkdir -p /tmp/files && \
     chmod ugo+rwx /tmp/files
USER gradle
RUN  mkdir -p ~/.ssh/ && \
     chmod 700 ~/.ssh && \
     echo "Host *\n\tStrictHostKeyChecking no\n" >> ~/.ssh/config
ENTRYPOINT ["/runme.sh"]
CMD []
