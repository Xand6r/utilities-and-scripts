# dockerfile for production
FROM nginx:1.15.2-alpine

# the react app should have been built `yarn build`
# so the dist folder would be available
COPY ./build /var/www
COPY nginx.conf /etc/nginx/nginx.conf

EXPOSE 80

ENTRYPOINT ["nginx","-g","daemon off;"]
