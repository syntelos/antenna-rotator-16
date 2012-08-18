#!/bin/bash

function usage {
    cat<<EOF>&2
Usage
    $0 name

Description
    Generate file 'name.scad' for module 'name'.

EOF
    exit 1
}

if [ "${1}" ]&&[ -z "$(echo ${1} | grep -e '-')" ]&&[ -z "$(echo ${1} | grep -e 'scad')" ]
then
    name=${1}
    cat<<EOF> ${name}.scad
/*
 * Antenna Rotator 16 kg-m
 * Copyright 2012 John Pritchard
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */


/*
 * employ "include", not "use", so the resolution and 
 * tolerance constants are shared
 */
include <constants.scad>;
include <fasteners.scad>;
include <gearmotor.scad>;
include <head.scad>;
include <mast.scad>;


${name}();

EOF
    ls -l ${name}.scad
else
    usage
fi
