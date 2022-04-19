/* devRC3UVersion.c */
/* Example device support for the lsi (long string input) record
 * providing the module version string as the value
 */

#include <stddef.h>
#include <stdio.h>
#include <string.h>

#include "devSup.h"
#include "lsiRecord.h"

#include "RC3UVersion.h"

/* must be last include */
#include "epicsExport.h"

const char version[] = RC3UVERSION;

static long read_string(lsiRecord *prec)
{
    size_t N = sizeof version;
    char *buf = prec->val;

    if (N > prec->sizv)
        N = prec->sizv;
    prec->len = N;

    memcpy(buf, version, N);
    buf[N - 1] = '\0';

    return 0;
}

static lsidset devRC3UVersion = {
    5, NULL, NULL, NULL, NULL, read_string
};
epicsExportAddress(dset,devRC3UVersion);
