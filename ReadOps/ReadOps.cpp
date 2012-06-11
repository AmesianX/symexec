#include "llvm/Pass.h"
#include "llvm/Function.h"
#include "llvm/Support/raw_ostream.h"

#include "llvm/Support/InstIterator.h"

using namespace llvm;

namespace {
  struct ReadOps : public FunctionPass {
    
    static char ID;
    ReadOps() : FunctionPass(ID) {}

    virtual bool runOnFunction(Function &F) {
      errs() << "Function: ";
      errs().write_escaped(F.getName()) << '\n';

      for (inst_iterator I = inst_begin(F), E = inst_end(F); I != E; ++I) {

          errs() << "Instruction: " << *I << "\n";
          //unsigned Opcode = I->getOpcode();   
          errs() << "Operator: " << I->getOpcodeName()<< "\n";

/*
           for (unsigned i = 0, e = I->getNumOperands(); i != e; ++i){

               Value* Opnum = I->getOperand(i);
               errs() << "Operand: " << *Opnum << "\n";

           }
*/
           
          for (User::op_iterator i = I->op_begin(), e = I->op_end(); i != e; ++i) {
              Value *v = *i;

              errs()<<"Operand: " << *v << '\n';
          }
          errs()<<"###############################\n";
      }

      for (Value::use_iterator i = F.use_begin(), e = F.use_end(); i != e; ++i)
          if (Instruction *Inst = dyn_cast<Instruction>(*i)) {
              errs() << "F is used in instruction:\n";
              errs() << *Inst << "\n";
          }

      return false;
    }

  };
}
  
char ReadOps::ID = 0;
static RegisterPass<ReadOps> X("read_ops", "ReadOps World Pass", false, false);
