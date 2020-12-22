FROM golang as builder

ENV GOPROXY=https://goproxy.io
RUN go get github.com/gohugoio/hugo

WORKDIR /app
ADD . /app

RUN cd themes/airspace-hugo/exampleSite/
RUN hugo --themesDir ../.. --baseUrl="https://aifusheng.com/"

FROM nginx as final
COPY --from=builder /app/themes/airspace-hugo/exampleSite/public /usr/share/nginx/html/

EXPOSE 80