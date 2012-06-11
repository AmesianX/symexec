#include "llvm/Pass.h"
#include "llvm/Function.h"
#include "llvm/Support/raw_ostream.h"

using namespace llvm;

namespace {
  struct Iteration : public FunctionPass {
    
    static char ID;
    Iteration() : FunctionPass(ID) {}

    virtual bool runOnFunction(Function &F) {
        errs() << "Hello: ";
        errs().write_escaped(F.getName()) << '\n';
        return false;
    }
  };
}
  
  
char Iteration::ID = 0;
static RegisterPass<Iteration> X("iteration", "Try iteration examples", false, false);



