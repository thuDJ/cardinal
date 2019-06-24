//* This file is part of the MOOSE framework
//* https://www.mooseframework.org
//*
//* All rights reserved, see COPYRIGHT for full restrictions
//* https://github.com/idaholab/moose/blob/master/COPYRIGHT
//*
//* Licensed under LGPL 2.1, please see LICENSE for details
//* https://www.gnu.org/licenses/lgpl-2.1.html

#pragma once

#include "MultiAppTransfer.h"

// Forward declarations
class NearestPointReceiverTransfer;

template <>
InputParameters validParams<NearestPointReceiverTransfer>();

/**
 * Copies the value of a Postprocessor from the Master to a MultiApp.
 */
class NearestPointReceiverTransfer : public MultiAppTransfer
{
public:
  NearestPointReceiverTransfer(const InputParameters & parameters);

  virtual void execute() override;

protected:
  UserObjectName _from_uo_name;
  UserObjectName _to_uo_name;
};