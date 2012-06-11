#include "llvm/Pass.h"
#include "llvm/Function.h"
#include "llvm/Support/raw_ostream.h"

#include "llvm/Support/InstIterator.h"

#include "llvm/Type.h"
#include "llvm/DerivedTypes.h"
#include "llvm/Constants.h"

#include <sstream>
#include <string>
#include <iostream>

using namespace llvm;
using namespace std;

namespace {
struct MaximallySharedGraph: public FunctionPass {

	static char ID;
	MaximallySharedGraph() :
			FunctionPass(ID) {
	}

	Instruction& findRet(Function &F) {
		for (inst_iterator I = inst_begin(F), E = inst_end(F); I != E; ++I) {
			unsigned Opcode = I->getOpcode();
			if (Opcode == Instruction::Ret)
				return *I;
		}
	}

	// Postorder traverse of a tree
	void print_inst_spear(Instruction& inst) {
		for (User::op_iterator i = inst.op_begin(), e = inst.op_end(); i != e;
				++i) {
			if (Instruction * sub_inst = dyn_cast<Instruction>(*i)) {
				print_inst_spear (*sub_inst);
			}
		}
		if(inst.getType()->getTypeID() == Type::IntegerTyID)
			errs() << "<i" << inst.getType()->getIntegerBitWidth() << "> ";
		if(inst.hasName())
			errs() << inst.getName() << " || ";
        errs() << inst.getOpcodeName();

		for (User::op_iterator i = inst.op_begin(), e = inst.op_end(); i != e;
				++i) {
			Value *v = *i;

			errs() << " || ";
			if(v->getType()->getTypeID() == Type::IntegerTyID)
				errs() << "<i" << v->getType()->getIntegerBitWidth() << "> ";
			if(v->hasName())
				errs() << v->getName() << " || ";
			else if(v->getValueID() == Value::ConstantIntVal)
				errs() << cast<ConstantInt>(v)->getValue()<< "||";

		}
		errs() << "\n";
	}

	// Postorder traverse of a tree
	void print_variables_spear(Instruction& inst) {
		for (User::op_iterator i = inst.op_begin(), e = inst.op_end(); i != e;
				++i) {
			if (Instruction * sub_inst = dyn_cast<Instruction>(*i)) {
				print_variables_spear (*sub_inst);
			}
		}
		errs() << "<" << inst.getType()->getTypeID()  << inst.getType()->getIntegerBitWidth() << "> ";
		errs() << inst << " || ";
        errs() << inst.getOpcodeName();

		for (User::op_iterator i = inst.op_begin(), e = inst.op_end(); i != e;
				++i) {
			Value *v = *i;
			errs() << " || " << "<" <<  v->getType()->getTypeID() << "> ";
			errs() << *v;
		}
		errs() << "\n";
	}

	void print_spear() {
		errs() << "# Should print the IR code's name here." << "\n";
		errs() << "v 1.0" << "\n";
		errs() << "d # Should print variable declarations here." << "\n";

		errs() << "p = ret 0:i32" << "\n";

	}

	virtual bool runOnFunction(Function &F) {
		errs() << "MaximallySharedGraph: \n";
		Instruction& retI = findRet(F);
		//print_graph(retI);
		print_inst_spear(retI);
		//print_variables_spear(retI);

		return false;
	}
};
}

char MaximallySharedGraph::ID = 0;
static RegisterPass<MaximallySharedGraph> X("maximally-shared-graph",
		"MaximallySharedGraph World Pass", false, false);
