DEPENDPATH += \
    $$PWD/azure-iot-sdk/c/iothub_client/inc \
    $$PWD/azure-iot-sdk/c/iothub_client/src \
    $$PWD/azure-iot-sdk/c/azure-c-shared-utility/c/inc \
    $$PWD/azure-iot-sdk/c/azure-c-shared-utility/c/src
INCLUDEPATH += \
    $$PWD/azure-iot-sdk/c/iothub_client/inc \
    $$PWD/azure-iot-sdk/c/azure-c-shared-utility/c/inc

#LIBS += -L/usr/lib/ -lqpid-proton
LIBS += -lcurl -lssl -lcrypto

QMAKE_CFLAGS += --std=c11
QMAKE_CFLAGS += -D_POSIX_C_SOURCE=200112L
QMAKE_CXXFLAGS += --std=c++11

HEADERS += \
    $$PWD/azure-iot-sdk/c/iothub_client/inc/iothub_client_amqp_internal.h \
    $$PWD/azure-iot-sdk/c/iothub_client/inc/iothub_client.h \
    $$PWD/azure-iot-sdk/c/iothub_client/inc/iothub_client_ll.h \
    $$PWD/azure-iot-sdk/c/iothub_client/inc/iothub_client_private.h \
    $$PWD/azure-iot-sdk/c/iothub_client/inc/iothub_message.h \
#    $$PWD/azure-iot-sdk/c/iothub_client/inc/iothubtransportamqp.h \
    $$PWD/azure-iot-sdk/c/iothub_client/inc/iothubtransporthttp.h \
#    $$PWD/azure-iot-sdk/c/iothub_client/inc/iothubtransportmqtt.h \
    $$PWD/azure-iot-sdk/c/iothub_client/inc/version.h \
    $$PWD/azure-iot-sdk/c/azure-c-shared-utility/c/inc/agenttime.h \
    $$PWD/azure-iot-sdk/c/azure-c-shared-utility/c/inc/base64.h \
    $$PWD/azure-iot-sdk/c/azure-c-shared-utility/c/inc/buffer_.h \
    $$PWD/azure-iot-sdk/c/azure-c-shared-utility/c/inc/condition.h \
    $$PWD/azure-iot-sdk/c/azure-c-shared-utility/c/inc/constbuffer.h \
    $$PWD/azure-iot-sdk/c/azure-c-shared-utility/c/inc/constmap.h \
    $$PWD/azure-iot-sdk/c/azure-c-shared-utility/c/inc/crt_abstractions.h \
    $$PWD/azure-iot-sdk/c/azure-c-shared-utility/c/inc/doublylinkedlist.h \
    $$PWD/azure-iot-sdk/c/azure-c-shared-utility/c/inc/gballoc.h \
    $$PWD/azure-iot-sdk/c/azure-c-shared-utility/c/inc/hmac.h \
    $$PWD/azure-iot-sdk/c/azure-c-shared-utility/c/inc/hmacsha256.h \
    $$PWD/azure-iot-sdk/c/azure-c-shared-utility/c/inc/httpapiex.h \
    $$PWD/azure-iot-sdk/c/azure-c-shared-utility/c/inc/httpapiexsas.h \
    $$PWD/azure-iot-sdk/c/azure-c-shared-utility/c/inc/httpapi.h \
    $$PWD/azure-iot-sdk/c/azure-c-shared-utility/c/inc/httpheaders.h \
    $$PWD/azure-iot-sdk/c/azure-c-shared-utility/c/inc/iot_logging.h \
    $$PWD/azure-iot-sdk/c/azure-c-shared-utility/c/inc/list.h \
    $$PWD/azure-iot-sdk/c/azure-c-shared-utility/c/inc/lock.h \
    $$PWD/azure-iot-sdk/c/azure-c-shared-utility/c/inc/macro_utils.h \
    $$PWD/azure-iot-sdk/c/azure-c-shared-utility/c/inc/map.h \
    $$PWD/azure-iot-sdk/c/azure-c-shared-utility/c/inc/mqttapi.h \
    $$PWD/azure-iot-sdk/c/azure-c-shared-utility/c/inc/platform.h \
    $$PWD/azure-iot-sdk/c/azure-c-shared-utility/c/inc/refcount.h \
    $$PWD/azure-iot-sdk/c/azure-c-shared-utility/c/inc/sastoken.h \
    $$PWD/azure-iot-sdk/c/azure-c-shared-utility/c/inc/sha.h \
    $$PWD/azure-iot-sdk/c/azure-c-shared-utility/c/inc/sha-private.h \
    $$PWD/azure-iot-sdk/c/azure-c-shared-utility/c/inc/socketio.h \
    $$PWD/azure-iot-sdk/c/azure-c-shared-utility/c/inc/stdint_ce6.h \
    $$PWD/azure-iot-sdk/c/azure-c-shared-utility/c/inc/strings.h \
    $$PWD/azure-iot-sdk/c/azure-c-shared-utility/c/inc/string_tokenizer.h \
    $$PWD/azure-iot-sdk/c/azure-c-shared-utility/c/inc/threadapi.h \
    $$PWD/azure-iot-sdk/c/azure-c-shared-utility/c/inc/tickcounter.h \
    $$PWD/azure-iot-sdk/c/azure-c-shared-utility/c/inc/tlsio.h \
    $$PWD/azure-iot-sdk/c/azure-c-shared-utility/c/inc/urlencode.h \
    $$PWD/azure-iot-sdk/c/azure-c-shared-utility/c/inc/vector.h \
    $$PWD/azure-iot-sdk/c/azure-c-shared-utility/c/inc/xio.h \
    $$PWD/azure-iot-sdk/c/azure-c-shared-utility/c/inc/xlogging.h \
    $$PWD/azure-iot-sdk/c/azure-c-shared-utility/c/inc/tlsio_openssl.h

#    $$PWD/azure-iot-sdk/c/azure-c-shared-utility/c/inc/tlsio_schannel.h \
#    $$PWD/azure-iot-sdk/c/azure-c-shared-utility/c/inc/tlsio_wolfssl.h \

SOURCES += \
    $$PWD/azure-iot-sdk/c/iothub_client/src/iothub_client.c \
    $$PWD/azure-iot-sdk/c/iothub_client/src/iothub_client_ll.c \
    $$PWD/azure-iot-sdk/c/iothub_client/src/iothub_message.c \
#    $$PWD/azure-iot-sdk/c/iothub_client/src/iothubtransportamqp.c \
    $$PWD/azure-iot-sdk/c/iothub_client/src/iothubtransporthttp.c \
#    $$PWD/azure-iot-sdk/c/iothub_client/src/iothubtransportmqtt.c \
    $$PWD/azure-iot-sdk/c/iothub_client/src/version.c \
    $$PWD/azure-iot-sdk/c/azure-c-shared-utility/c/src/base64.c \
    $$PWD/azure-iot-sdk/c/azure-c-shared-utility/c/src/buffer.c \
    $$PWD/azure-iot-sdk/c/azure-c-shared-utility/c/src/constbuffer.c \
    $$PWD/azure-iot-sdk/c/azure-c-shared-utility/c/src/constmap.c \
    $$PWD/azure-iot-sdk/c/azure-c-shared-utility/c/src/crt_abstractions.c \
    $$PWD/azure-iot-sdk/c/azure-c-shared-utility/c/src/doublylinkedlist.c \
    $$PWD/azure-iot-sdk/c/azure-c-shared-utility/c/src/gballoc.c \
    $$PWD/azure-iot-sdk/c/azure-c-shared-utility/c/src/hmac.c \
    $$PWD/azure-iot-sdk/c/azure-c-shared-utility/c/src/hmacsha256.c \
    $$PWD/azure-iot-sdk/c/azure-c-shared-utility/c/src/httpapiex.c \
    $$PWD/azure-iot-sdk/c/azure-c-shared-utility/c/src/httpapiexsas.c \
    $$PWD/azure-iot-sdk/c/azure-c-shared-utility/c/src/httpheaders.c \
    $$PWD/azure-iot-sdk/c/azure-c-shared-utility/c/src/list.c \
    $$PWD/azure-iot-sdk/c/azure-c-shared-utility/c/src/map.c \
    $$PWD/azure-iot-sdk/c/azure-c-shared-utility/c/src/sastoken.c \
    $$PWD/azure-iot-sdk/c/azure-c-shared-utility/c/src/sha1.c \
    $$PWD/azure-iot-sdk/c/azure-c-shared-utility/c/src/sha224.c \
    $$PWD/azure-iot-sdk/c/azure-c-shared-utility/c/src/sha384-512.c \
    $$PWD/azure-iot-sdk/c/azure-c-shared-utility/c/src/strings.c \
    $$PWD/azure-iot-sdk/c/azure-c-shared-utility/c/src/string_tokenizer.c \
    $$PWD/azure-iot-sdk/c/azure-c-shared-utility/c/src/tickcounter.c \
    $$PWD/azure-iot-sdk/c/azure-c-shared-utility/c/src/urlencode.c \
    $$PWD/azure-iot-sdk/c/azure-c-shared-utility/c/src/usha.c \
    $$PWD/azure-iot-sdk/c/azure-c-shared-utility/c/src/vector.c \
    $$PWD/azure-iot-sdk/c/azure-c-shared-utility/c/src/xio.c \
    $$PWD/azure-iot-sdk/c/azure-c-shared-utility/c/adapters/condition_pthreads.c \
    $$PWD/azure-iot-sdk/c/azure-c-shared-utility/c/adapters/httpapi_curl.c \
    $$PWD/azure-iot-sdk/c/azure-c-shared-utility/c/adapters/lock_pthreads.c \
    $$PWD/azure-iot-sdk/c/azure-c-shared-utility/c/adapters/platform_linux.c \
    $$PWD/azure-iot-sdk/c/azure-c-shared-utility/c/adapters/socketio_berkeley.c \
    $$PWD/azure-iot-sdk/c/azure-c-shared-utility/c/adapters/threadapi_pthreads.c \
    $$PWD/azure-iot-sdk/c/azure-c-shared-utility/c/adapters/agenttime.c \
    $$PWD/azure-iot-sdk/c/azure-c-shared-utility/c/src/tlsio_openssl.c

#    $$PWD/azure-iot-sdk/c/azure-c-shared-utility/c/src/tlsio_schannel.c \
#    $$PWD/azure-iot-sdk/c/azure-c-shared-utility/c/src/tlsio_wolfssl.c \
