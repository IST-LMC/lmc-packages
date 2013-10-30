/*
 * NB:  This file is machine generated, DO NOT EDIT!
 *
 * Edit vmod.vcc and run vmod.py instead
 */

#include "vrt.h"
#include "vcc_if.h"
#include "vmod_abi.h"


typedef double td_throttle_is_allowed(struct sess *, struct vmod_priv *, const char *, const char *);
typedef int td_throttle_remaining_calls(struct sess *, struct vmod_priv *, const char *, const char *);
typedef int td_throttle_memory_usage(struct sess *, struct vmod_priv *);

const char Vmod_Name[] = "throttle";
const struct Vmod_Func_throttle {
	td_throttle_is_allowed	*is_allowed;
	td_throttle_remaining_calls	*remaining_calls;
	td_throttle_memory_usage	*memory_usage;
	vmod_init_f	*_init;
} Vmod_Func = {
	vmod_is_allowed,
	vmod_remaining_calls,
	vmod_memory_usage,
	init_function,
};

const int Vmod_Len = sizeof(Vmod_Func);

const char Vmod_Proto[] =
	"typedef double td_throttle_is_allowed(struct sess *, struct vmod_priv *, const char *, const char *);\n"
	"typedef int td_throttle_remaining_calls(struct sess *, struct vmod_priv *, const char *, const char *);\n"
	"typedef int td_throttle_memory_usage(struct sess *, struct vmod_priv *);\n"
	"\n"
	"struct Vmod_Func_throttle {\n"
	"	td_throttle_is_allowed	*is_allowed;\n"
	"	td_throttle_remaining_calls	*remaining_calls;\n"
	"	td_throttle_memory_usage	*memory_usage;\n"
	"	vmod_init_f	*_init;\n"
	"} Vmod_Func_throttle;\n"
	;

const char * const Vmod_Spec[] = {
	"throttle.is_allowed\0Vmod_Func_throttle.is_allowed\0DURATION\0PRIV_VCL\0STRING\0STRING\0",
	"throttle.remaining_calls\0Vmod_Func_throttle.remaining_calls\0INT\0PRIV_VCL\0STRING\0STRING\0",
	"throttle.memory_usage\0Vmod_Func_throttle.memory_usage\0INT\0PRIV_VCL\0",
	"INIT\0Vmod_Func_throttle._init",
	0
};
const char Vmod_Varnish_ABI[] = VMOD_ABI_Version;
const void * const Vmod_Id = &Vmod_Id;

