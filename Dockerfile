# instruksi ini menspesifikan base image yang digunakan sebagai dasar dari dockerfile
FROM golang:alpine

# intruksi untuk menjalankan command di container. command dieksekusi sebagai comand shell di dalam container, /bin/sh atau cmd di Windows. RUN akan membuat layer baru disetiap RUN command best practice penggunaan RUN dengan menggabung multiple command dengan &&
RUN apk update && apk add git

#environment variable
ENV PORT=8083
ENV INSTANCE_ID="dockerfile"

#menetapkan direktori kerja saat ini
WORKDIR /app

#intruksi untuk mengcopy  dari host ke docker image,
# dot titik pertama mengarahkan ke direktori di host tempat dimana Dockerfile berada
# dot titik kedua mengarahkan ke current direktori dalam image dalam konteks ini berada di /app
COPY . .

#intruksi untuk memvalidasi source code golang
RUN go mod tidy

#Intruksi ini untuk membuild source code golang menjadi binary executeable
RUN go build -o binary

#intruksi ini berguna jika sewaktu build source code ini akan dijalankan  dan image akan di run ke container, binary akan di execute
ENTRYPOINT ["./binary"]