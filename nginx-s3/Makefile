all:
	abuild -r

stub:

PRJ =  "openssl/openssl OpenSSL_1_1_1-pre2"
PRJ += "vozlt/nginx-module-vts master"
PRJ += "aperezdc/ngx-fancyindex master"
PRJ += "google/ngx_brotli master"
PRJ += "nginx/njs 0.2.0"

BASEDIR = $(shell pwd)
OUTPUT_LOG := "$(BASEDIR)/artefact/build-$(shell date +%s).log"
NGINX_VER = $(shell $(BASEDIR)/nginx_lastVersion.sh)

default: build

_version:
        @echo $(NGINX_VER)

check:
        @_verRemote=$$(echo $(NGINX_VER) | cut -f2 -d' '); \
                _verLocal=$$(/opt/local/sbin/nginx -v 2>&1  | cut -f2 -d'/'); \
                [ "$${_verRemote}" == "$${_verLocal}" ] \
                        && echo "Local version $${_verLocal} is up-to-date !" && exit 1; \
        ( echo "CHANGE LOG between $${_verLocal}" to "$${_verRemote}" && curl -Ls https://nginx.org/en/CHANGES \
                | awk "BEGIN { out = 0; } \
                        /Changes with nginx $${_verRemote}/ { out = 1; } \
                        /Changes with nginx $${_verLocal}/ { out = 0; }  \
                        { if( out == 1 ) { printf(\"%s\n\", \$$0); } }" ) | less; \
        echo -n "OK to build [Y/n] ? " && read _k && if [ "$$_k" == "y" -o "$$_k" == "Y" -o -z "$$_k" ]; then true; else false; fi

checkout:
        @echo -n "Setup env and build nginx ..." | tee -a $(OUTPUT_LOG)
        @( cd deps && for prj in $(PRJ); do \
                path="$${prj% *}"; branch="$${prj#* }"; \
                if [ ! -d "$${path#*/}" ]; then \
                        git clone --recurse-submodules --single-branch -b $${branch} https://github.com/$${path} 2>&1 ; \
                else \
                        cd "$${path#*/}" && git fetch --all -t && git checkout -q $${branch} 2>&1 && cd - ; \
                fi \
        done ) | tee -a $(OUTPUT_LOG) | while read; do echo -n '.'; done;

build: check
        make force

force: checkout
        @( curl -Ls $$(echo $(NGINX_VER) | cut -f1 -d' ') | tar -xzvf - | tee -a $(OUTPUT_LOG) | while read; do echo -n '.'; done ; \
        cd nginx-release-* ; \
        for p in $$(find ../patches/ -name "nginx_$$(echo $(NGINX_VER) | cut -f2 -d' ')_*.p0" -type f); do \
                echo -ne "\n[PATCH][$${p}] - " && patch -p0 < $${p}; \
        done ; \
        cp ../go.nginx . ; \
        sh go.nginx | tee -a $(OUTPUT_LOG) | while read; do echo -n '.'; done ; \
        echo; \
        make -j16 2>&1 | awk '\
                /cc -c/ { _action="[NGX][CC]"; } \
                /cc -o/ { printf("LNK [nginx]\n"); } \
                match($$0, /^[ \t]+-o ([^ ]+)/, _arr) { _output=_arr[1]; } \
                match($$0, /^[ \t]+(src\/.+)/, _arr) { printf("%s %s --> %s\n", _action, _arr[1], _output); } \
                match($$0, /gcc.+ ([a-zA-Z0-9\/_]+).(c|cpp)$$/ , _arr) { printf("[SSL][CC] %s.c --> %s.o\n", _arr[1], _arr[1]); } ' \
                && ./objs/nginx -V && strip ./objs/nginx ; \
        echo "sudo mv /opt/local/sbin/nginx /opt/local/sbin/nginx.old"; \
        echo "sudo cp $$(pwd)/objs/nginx /opt/local/sbin"; \
        echo "sudo /opt/local/sbin/nginx.old -s stop && sleep 2 && sudo /opt/local/sbin/nginx" ) 2>&1 | tee -a $(OUTPUT_LOG) ;

clean:
        @for prj in $(PRJ); do \
                path="$${prj% *}"; branch="$${prj#* }"; \
                rm -rf "deps/$${path#*/}"; \
        done; \
        rm -rf nginx-release-*


