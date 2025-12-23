#include <stdio.h>
#include <sys/io.h>
#include <unistd.h>

#define KBD_DATA_REG 0x60
#define KBD_STATUS_REG 0x64
#define KBD_CMD_SET_LEDS 0xED

void wait_kbd() {
    while(inb(KBD_STATUS_REG) & 0x02); // Wait until buffer is empty
}

int main(int argc, char *argv[]) {
    if (argc < 2) return 1;
    int state = (argv[1][0] == '1') ? 0x04 : 0x00; // 0x04 is the bit for CapsLock

    if (ioperm(KBD_DATA_REG, 1, 1) || ioperm(KBD_STATUS_REG, 1, 1)) {
        perror("ioperm");
        return 1;
    }

    wait_kbd();
    outb(KBD_CMD_SET_LEDS, KBD_DATA_REG);
    wait_kbd();
    outb(state, KBD_DATA_REG);

    return 0;
}
