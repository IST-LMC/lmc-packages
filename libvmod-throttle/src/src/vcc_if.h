/*
 * NB:  This file is machine generated, DO NOT EDIT!
 *
 * Edit vmod.vcc and run vmod.py instead
 */

struct sess;
struct VCL_conf;
struct vmod_priv;

double vmod_is_allowed(struct sess *, struct vmod_priv *, const char *, const char *);
int vmod_remaining_calls(struct sess *, struct vmod_priv *, const char *, const char *);
int vmod_memory_usage(struct sess *, struct vmod_priv *);
int init_function(struct vmod_priv *, const struct VCL_conf *);
extern const void * const Vmod_Id;
