FROM alpine:3.12 as build

RUN apk add build-base abuild binutils binutils-doc cmake musl musl-dev
RUN apk add git
ENV CC "/usr/bin/x86_64-alpine-linux-musl-gcc -static -Os"
RUN mkdir flatc && git clone https://github.com/google/flatbuffers.git flatc
RUN cd flatc && \ 
	cmake -G "Unix Makefiles" -DCMAKE_BUILD_TYPE=Release && \
	cmake -DCMAKE_C_COMPILER="/usr/bin/x86_64-alpine-linux-musl-gcc" -DCMAKE_EXE_LINKER_FLAGS="-static -Os" . && \
	cmake --build .

FROM alpine:3.12
RUN mkdir flatc && cd flatc
COPY --from=build /flatc/flatc ./flatc
RUN chmod +x flatc
ENTRYPOINT ["/flatc/flatc"]
