#!/bin/sh

systemctl daemon-reload
systemctl start tomcat.service
systemctl enable tomcat.service

exec "$@"