#-------------------------------------------------------------------------------
# Copyright (c) 2010-2013, Jean-David Gadina - www.xs-labs.com
# All rights reserved.
# 
# XEOS Software License - Version 1.0 - December 21, 2012
# 
# Permission is hereby granted, free of charge, to any person or organisation
# obtaining a copy of the software and accompanying documentation covered by
# this license (the "Software") to deal in the Software, with or without
# modification, without restriction, including without limitation the rights
# to use, execute, display, copy, reproduce, transmit, publish, distribute,
# modify, merge, prepare derivative works of the Software, and to permit
# third-parties to whom the Software is furnished to do so, all subject to the
# following conditions:
# 
#       1.  Redistributions of source code, in whole or in part, must retain the
#           above copyright notice and this entire statement, including the
#           above license grant, this restriction and the following disclaimer.
# 
#       2.  Redistributions in binary form must reproduce the above copyright
#           notice and this entire statement, including the above license grant,
#           this restriction and the following disclaimer in the documentation
#           and/or other materials provided with the distribution, unless the
#           Software is distributed by the copyright owner as a library.
#           A "library" means a collection of software functions and/or data
#           prepared so as to be conveniently linked with application programs
#           (which use some of those functions and data) to form executables.
# 
#       3.  The Software, or any substancial portion of the Software shall not
#           be combined, included, derived, or linked (statically or
#           dynamically) with software or libraries licensed under the terms
#           of any GNU software license, including, but not limited to, the GNU
#           General Public License (GNU/GPL) or the GNU Lesser General Public
#           License (GNU/LGPL).
# 
#       4.  All advertising materials mentioning features or use of this
#           software must display an acknowledgement stating that the product
#           includes software developed by the copyright owner.
# 
#       5.  Neither the name of the copyright owner nor the names of its
#           contributors may be used to endorse or promote products derived from
#           this software without specific prior written permission.
# 
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT OWNER AND CONTRIBUTORS "AS IS"
# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
# THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
# PURPOSE, TITLE AND NON-INFRINGEMENT ARE DISCLAIMED.
# 
# IN NO EVENT SHALL THE COPYRIGHT OWNER, CONTRIBUTORS OR ANYONE DISTRIBUTING
# THE SOFTWARE BE LIABLE FOR ANY CLAIM, DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
# EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
# PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS;
# OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
# WHETHER IN ACTION OF CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
# NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF OR IN CONNECTION WITH
# THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE, EVEN IF ADVISED
# OF THE POSSIBILITY OF SUCH DAMAGE.
#-------------------------------------------------------------------------------

# $Id$

include ../../../Makefile-Config.mk

#-------------------------------------------------------------------------------
# Display
#-------------------------------------------------------------------------------

PROMPT  := "    ["$(COLOR_GREEN)" XEOS "$(COLOR_NONE)"]> ["$(COLOR_GREEN)" SRC  "$(COLOR_NONE)"]> ["$(COLOR_GREEN)" CORE "$(COLOR_NONE)"]> ["$(COLOR_GREEN)" ACPI "$(COLOR_NONE)"]> *** "

#-------------------------------------------------------------------------------
# Files
#-------------------------------------------------------------------------------

_FILES          = $(call XEOS_FUNC_C_OBJ,$(PATH_SRC_CORE_ACPI)acpi/)
_FILES         += $(call XEOS_FUNC_C_OBJ,$(PATH_SRC_CORE_ACPI)osl/)

_FILES_ACPICA   = $(call XEOS_FUNC_C_OBJ,$(PATH_SRC_CORE_ACPI)acpica/source/components/debugger/)
_FILES_ACPICA  += $(call XEOS_FUNC_C_OBJ,$(PATH_SRC_CORE_ACPI)acpica/source/components/disassembler/)
_FILES_ACPICA  += $(call XEOS_FUNC_C_OBJ,$(PATH_SRC_CORE_ACPI)acpica/source/components/dispatcher/)
_FILES_ACPICA  += $(call XEOS_FUNC_C_OBJ,$(PATH_SRC_CORE_ACPI)acpica/source/components/events/)
_FILES_ACPICA  += $(call XEOS_FUNC_C_OBJ,$(PATH_SRC_CORE_ACPI)acpica/source/components/executer/)
_FILES_ACPICA  += $(call XEOS_FUNC_C_OBJ,$(PATH_SRC_CORE_ACPI)acpica/source/components/hardware/)
_FILES_ACPICA  += $(call XEOS_FUNC_C_OBJ,$(PATH_SRC_CORE_ACPI)acpica/source/components/namespace/)
_FILES_ACPICA  += $(call XEOS_FUNC_C_OBJ,$(PATH_SRC_CORE_ACPI)acpica/source/components/parser/)
_FILES_ACPICA  += $(call XEOS_FUNC_C_OBJ,$(PATH_SRC_CORE_ACPI)acpica/source/components/resources/)
_FILES_ACPICA  += $(call XEOS_FUNC_C_OBJ,$(PATH_SRC_CORE_ACPI)acpica/source/components/tables/)
_FILES_ACPICA  += $(call XEOS_FUNC_C_OBJ,$(PATH_SRC_CORE_ACPI)acpica/source/components/utilities/)

#-------------------------------------------------------------------------------
# Built-in targets
#-------------------------------------------------------------------------------

# Declaration for phony targets, to avoid problems with local files
.PHONY: all clean acpi acpica

#-------------------------------------------------------------------------------
# Phony targets
#-------------------------------------------------------------------------------

# Build the full project
all: acpi acpica
	
	@:

# Cleans the build files
clean:
	
	@$(PRINT) $(PROMPT)"Cleaning all build files"
	@$(RM) $(ARGS_RM) $(PATH_BUILD_32_OBJ)$(subst $(PATH_SRC),,$(PATH_SRC_CORE_ACPI))
	@$(RM) $(ARGS_RM) $(PATH_BUILD_64_OBJ)$(subst $(PATH_SRC),,$(PATH_SRC_CORE_ACPI))
	@$(RM) $(ARGS_RM) $(PATH_BUILD_32_BIN)libcore-acpi.*
	@$(RM) $(ARGS_RM) $(PATH_BUILD_64_BIN)libcore-acpi.*
	@$(RM) $(ARGS_RM) $(PATH_BUILD_32_BIN)libcore-acpi-acpica.*
	@$(RM) $(ARGS_RM) $(PATH_BUILD_64_BIN)libcore-acpi-acpica.*

# ACPI support files
acpi: $(_FILES)
	
	@$(PRINT) $(PROMPT)$(COLOR_CYAN)"Generating the library archive"$(COLOR_NONE)" [ 32 bits ]: "$(COLOR_GRAY)"libcore-acpi.a"$(COLOR_NONE)
	@$(call XEOS_FUNC_LIB_STATIC_32,libcore-acpi,$^)
	
	@$(PRINT) $(PROMPT)$(COLOR_CYAN)"Generating the library archive"$(COLOR_NONE)" [ 64 bits ]: "$(COLOR_GRAY)"libcore-acpi.a"$(COLOR_NONE)
	@$(call XEOS_FUNC_LIB_STATIC_64,libcore-acpi,$^)

# ACPICA library
acpica: ARGS_CC_32 := -include acpi/acpica-clang-warnings.h -iquote $(PATH_SRC_CORE_ACPI)include/acpi/acpica $(ARGS_CC_32)
acpica: ARGS_CC_64 := -include acpi/acpica-clang-warnings.h -iquote $(PATH_SRC_CORE_ACPI)include/acpi/acpica $(ARGS_CC_64)
acpica: $(_FILES_ACPICA)
	
	@$(PRINT) $(PROMPT)$(COLOR_CYAN)"Generating the library archive"$(COLOR_NONE)" [ 32 bits ]: "$(COLOR_GRAY)"libcore-acpi-acpica.a"$(COLOR_NONE)
	@$(call XEOS_FUNC_LIB_STATIC_32,libcore-acpi-acpica,$^)
	
	@$(PRINT) $(PROMPT)$(COLOR_CYAN)"Generating the library archive"$(COLOR_NONE)" [ 64 bits ]: "$(COLOR_GRAY)"libcore-acpi-acpica.a"$(COLOR_NONE)
	@$(call XEOS_FUNC_LIB_STATIC_64,libcore-acpi-acpica,$^)
