#Build Phase
FROM node:alpine

USER node

RUN mkdir -p /home/node/app
WORKDIR '/home/node/app'

COPY --chown=node:node ./package*.json ./
RUN npm install

COPY --chown=node:node  ./ ./

RUN ls -l /home/node/app/

CMD ["npm", "run", "build"]

#Run Phase

FROM nginx
EXPOSE 80
#Copy from different phase
COPY --from=0 /home/node/app/build /usr/share/nginx/html

