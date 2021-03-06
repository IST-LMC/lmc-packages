/* ========================================================================
 * Copyright 2008 University of Washington
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 * ========================================================================
 */

/*
 * pbc_path.h, The pubcookie path.
 *
 * So that we can just #include this file instead of having to 
 * worry about shell escapes and whatnot.
 * 
 * $Id: pbc_path.h.in,v 2.16 2008/05/16 22:09:10 willey Exp $
 */


#ifndef PBC_PATH_H
#define PBC_PATH_H

#define PBC_PATH (libpbc_config_getstring(p, "pbc_path", "/usr/local/pubcookie/"))
/* the login server builds it's key Filenames from the hostname     */
#if defined (WIN32)
#  define PBC_KEY_DIR (AddSystemRoot("\\inetsrv\\pubcookie\\keys"))
#else
#  define PBC_KEY_DIR (libpbc_config_getstring(p, "keydir", "/usr/local/pubcookie/keys"))
#endif

/* where the runtime configuration file lives */
#define PBC_CONFIG "/usr/local/pubcookie/config"

/* Where to find templates */
#define TMPL_FNAME (libpbc_config_getstring(p, "template_root", "/usr/local/pubcookie/login_templates"))

/* suffix for seperate config files for components */
#define PBC_SUBCONFIG (libpbc_config_getstring(p, "subconfig_suffix", ".conf"))

/* file to get the list of ok browsers from */
#define OK_BROWSERS_FILE (libpbc_config_getstring(p, "ok_browsers", "/usr/local/pubcookie/ok_browsers"))

/* file to get browser information from */
#define BROWSERS_FILE (libpbc_config_getstring(p, "browsers", "/usr/local/pubcookie/browsers"))

/* getcred authz file */
#define GETCRED_AUTHZ (libpbc_config_getstring(p, "getcred_authz_file", "/usr/local/pubcookie/getcred_authz"))

/* The keyclient.  This is probably better defined elsewhere, but I dunno. */

#define KEYCLIENT (libpbc_config_getstring(p, "keyclient", "/usr/local/pubcookie/keyclient"))

/* The path to the cert db, if this is using the Netscape SDK */

#define CERT_DB_PATH (libpbc_config_getstring(p, "cert_db_path", "/usr/local/pubcookie/keys"))

#define SHADOW_PATH (libpbc_config_getstring(p, "shadow_path", "/etc/shadow"))

#endif
