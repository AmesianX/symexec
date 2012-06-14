#include "llvm/Pass.h"
#include "llvm/Function.h"
#include "llvm/Support/raw_ostream.h"

#include "llvm/Support/InstIterator.h"
#include "llvm/Support/MDBuilder.h"
#include "llvm/LLVMContext.h"

#include "llvm/Type.h"
#include "llvm/DerivedTypes.h"
#include "llvm/Constants.h"
#include "llvm/Instruction.h"
#include "llvm/InstrTypes.h"

#include <sstream>
#include <string>
#include <iostream>
#include <set>

using namespace llvm;
using namespace std;

namespace {
struct SpearGen: public FunctionPass {

	static char ID;
	SpearGen() :
			FunctionPass(ID) {
	}


	const char *get_spear_op(unsigned OpCode, CmpInst::Predicate p) {
		switch (OpCode) {
		// Terminators
		case Instruction:: Ret:    return "ret";
		case Instruction:: Br:     return "br";
		case Instruction:: Switch: return "switch";
		case Instruction:: IndirectBr: return "indirectbr";
		case Instruction:: Invoke: return "invoke";
		case Instruction:: Resume: return "resume";
		case Instruction:: Unreachable: return "unreachable";

		// Standard binary operators...
		case Instruction::Add: return "+";
		case Instruction::FAdd: return "fadd";
		case Instruction::Sub: return "sub";
		case Instruction::FSub: return "fsub";
		case Instruction::Mul: return "*";
		case Instruction::FMul: return "fmul";
		case Instruction::UDiv: return "udiv";
		case Instruction::SDiv: return "sdiv";
		case Instruction::FDiv: return "fdiv";
		case Instruction::URem: return "urem";
		case Instruction::SRem: return "srem";
		case Instruction::FRem: return "frem";

		// Logical operators...
		case Instruction::And: return "and";
		case Instruction::Or : return "or";
		case Instruction::Xor: return "xor";

		// Memory instructions...
		case Instruction::Alloca:        return "alloca";
		case Instruction::Load:          return "load";
		case Instruction::Store:         return "store";
		case Instruction::AtomicCmpXchg: return "cmpxchg";
		case Instruction::AtomicRMW:     return "atomicrmw";
		case Instruction::Fence:         return "fence";
		case Instruction::GetElementPtr: return "getelementptr";

		// Convert instructions...
		case Instruction::Trunc:     return "trunc";
		case Instruction::ZExt:      return "zext";
		case Instruction::SExt:      return "sext";
		case Instruction::FPTrunc:   return "fptrunc";
		case Instruction::FPExt:     return "fpext";
		case Instruction::FPToUI:    return "fptoui";
		case Instruction::FPToSI:    return "fptosi";
		case Instruction::UIToFP:    return "uitofp";
		case Instruction::SIToFP:    return "sitofp";
		case Instruction::IntToPtr:  return "inttoptr";
		case Instruction::PtrToInt:  return "ptrtoint";
		case Instruction::BitCast:   return "bitcast";

		// Other instructions...
		case Instruction::ICmp:           // return "icmp";
		case Instruction::FCmp:           // return "fcmp";
		{
			switch (p){
			case  CmpInst::ICMP_EQ:
			case  CmpInst::FCMP_OEQ:
			case  CmpInst::FCMP_UEQ:
				return "=";
			default: return "<Unhandled predicate> ";
			}
		}
		case Instruction::PHI:            return "phi";
		case Instruction::Select:         return "select";
		case Instruction::Call:           return "call";
		case Instruction::Shl:            return "shl";
		case Instruction::LShr:           return "lshr";
		case Instruction::AShr:           return "ashr";
		case Instruction::VAArg:          return "va_arg";
		case Instruction::ExtractElement: return "extractelement";
		case Instruction::InsertElement:  return "insertelement";
		case Instruction::ShuffleVector:  return "shufflevector";
		case Instruction::ExtractValue:   return "extractvalue";
		case Instruction::InsertValue:    return "insertvalue";
		case Instruction::LandingPad:     return "landingpad";

		default: return "<Invalid operator> ";
		}
	}

	enum visit_tag{
		IS_INST_VISITED=9733,
		IS_VAR_VISITED=9734
	}; // I randomly pick some values, which seem will not conflict with existing ones. Yet still not sure.

	Instruction& findRet(Function &F) {
		for (inst_iterator I = inst_begin(F), E = inst_end(F); I != E; ++I) {
			unsigned Opcode = I->getOpcode();
			if (Opcode == Instruction::Ret)
				return *I;

		}
	}

	void setVisited(Instruction& inst, visit_tag vtag) {
		Value *Elts[] = { MDString::get(inst.getContext(),
				"Avoid multi-generation for the same instruction.") };
		MDNode *MSGTag = MDNode::get(getGlobalContext(), Elts);
		inst.setMetadata(vtag, MSGTag);
	}

	bool isVisited(Instruction& inst, visit_tag vtag){
		MDNode * MSGTag = inst.getMetadata(vtag);
		if(MSGTag)
			return true;//errs() << *MSGTag << " visited" << "\n";
		else
			return false;
	}



	// Postorder traverse of a tree
	void print_inst_spear(Instruction& inst) {

		if (isVisited(inst, IS_INST_VISITED))
			return;
		else
			setVisited(inst, IS_INST_VISITED);

		// Print the operands' definitions fist and recursively.
		for (User::op_iterator i = inst.op_begin(), e = inst.op_end(); i != e;
				++i) {
			if (Instruction * sub_inst = dyn_cast<Instruction>(*i)) {
				print_inst_spear (*sub_inst);
			}
		}

		if (inst.getOpcode() == Instruction::Ret)
			return;

		errs() << "c ";

		// Print the return variable's name.
		if (inst.hasName())
			errs() << inst.getName() << " ";

		// Print the operator's name.
		if (isa <CmpInst> (inst) ){
			CmpInst& cmpInst = cast<CmpInst> (inst);
			errs() << get_spear_op(cmpInst.getOpcode(), cmpInst.getPredicate()) << " ";
		}
		else
			errs() << get_spear_op(inst.getOpcode(), CmpInst::BAD_ICMP_PREDICATE) << " ";





		// Print each operand: a variable name or a constant with type.
		for (User::op_iterator i = inst.op_begin(), e = inst.op_end(); i != e;
				++i) {
			Value *v = *i;

			if (v->hasName())
				errs() << v->getName()<< " ";

			if (v->getValueID() == Value::ConstantIntVal)
				errs() << cast<ConstantInt>(v)->getValue() << ":i"
						<< cast<ConstantInt>(v)->getType()->getIntegerBitWidth() << " ";

		}
		errs() << "\n";
	}


	set<StringRef> visited_variables;

	void print_variables_spear_of(Function &F) {
		this->visited_variables.clear();
		Instruction& retI = findRet(F);
		print_variables_spear_from(retI);
		errs() << "\n";
	}

	// Postorder traverse of a tree
	void print_variables_spear_from(Instruction& inst) {
		if (isVisited(inst, IS_VAR_VISITED))
			return;
		else
			setVisited(inst, IS_VAR_VISITED);

		for (User::op_iterator i = inst.op_begin(), e = inst.op_end(); i != e;
				++i) {
			Value *v = *i;
			if (isa<Argument>(i)) {
				StringRef vname = v->getName();
				if (visited_variables.find(vname) == visited_variables.end()) {
					errs() << vname << ":i"
							<< v->getType()->getIntegerBitWidth() << " ";
					visited_variables.insert(vname);
				}
			}

			if (Instruction * sub_inst = dyn_cast<Instruction>(*i)) {
				print_variables_spear_from (*sub_inst);
			}
		}

		if (inst.hasName()) {
			StringRef iname = inst.getName();
			errs() << iname;
			visited_variables.insert(iname);
			if (inst.getType()->getTypeID() == Type::IntegerTyID)
				errs() << ":i" << inst.getType()->getIntegerBitWidth() << " ";
		}
	}

	void print_spear(Function &F) {
		errs() << "# Should print the IR file's name here." << "\n";
		errs() << "v 1.0" << "\n";
		errs() << "d ";
		print_variables_spear_of(F);


		Instruction& retI = findRet(F);
		print_inst_spear(retI);

		Value *v = retI.getOperand(0);
		if(v->hasName())
			errs()  << "p = " << v->getName() << " 0:i32 \n" ;
		else
			errs()  << "p = " << cast<ConstantInt>(v)->getValue() << ":i"
					<< v->getType()->getIntegerBitWidth()  << " 0:i32 \n" ;

	}

	virtual bool runOnFunction(Function &F) {
		errs() << "# Pass SpearGen: \n";
		print_spear(F);

		return false;
	}
};
}

char SpearGen::ID = 0;
static RegisterPass<SpearGen> X("spear-gen", "SpearGen World Pass", false,
		false);