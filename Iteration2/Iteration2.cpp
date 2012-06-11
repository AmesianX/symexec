#include "llvm/Pass.h"
#include "llvm/Function.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/Support/InstIterator.h"

using namespace llvm;

namespace {
  struct Iteration2 : public FunctionPass {
    
    static char ID;
    Iteration2() : FunctionPass(ID) {}

    virtual bool runOnFunction(Function &F) {
      errs() << "Iteration2: ";
      errs().write_escaped(F.getName()) << '\n';
      /*
      // F is a reference to a Function 
      for (Function::iterator i = F.begin(), e = F.end(); i != e; ++i)
          errs() << "Basic block (name=" << i->getName() << ") has "
                 << i->size() << " instructions.\n";
      for (inst_iterator I = inst_begin(F), E = inst_end(F); I != E; ++I)
          errs() << *I << "\n";
      */
        
      for (Value::use_iterator i = F.use_begin(), e = F.use_end(); i != e; ++i)
          if (Instruction *Inst = dyn_cast<Instruction>(*i)) {
             errs() << "F is used in instruction:\n";
             errs() << *Inst << "\n";
             Instruction *pi = Inst;
             int cnt=0;
             for (User::op_iterator i = pi->op_begin(), e = pi->op_end(); i != e; ++i) {
                  Value *v = *i;
                  cnt++;
                  errs() << "##############" << cnt << "##############"  << "\n";
                  errs() << *v << "\n";
                  
                  // ...
             }
          }
      return false;
    }

  };
}
  
char Iteration2::ID = 0;
static RegisterPass<Iteration2> X("iteration2", "Iteration2 World Pass", false, false);
