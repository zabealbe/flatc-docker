FROM alpine:3.12 as build

RUN apk add build-base gcc abuild binutils binutils-doc cmake
RUN apk add git
RUN mkdir flatc && git clone https://github.com/google/flatbuffers.git flatc
RUN cd flatc && \ 
	cmake -G "Unix Makefiles" -DCMAKE_BUILD_TYPE=Release && \
	cmake . && \
	cmake --build .

FROM alpine:3.12
RUN apk add gcc
RUN mkdir flatc && cd flatc
COPY --from=build /flatc/flatc ./flatc
RUN chmod +x flatc
ENTRYPOINT ["/flatc/flatc"]
