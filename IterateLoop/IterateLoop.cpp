#include "llvm/Pass.h"
#include "llvm/Analysis/LoopPass.h"
#include "llvm/Support/raw_ostream.h"

using namespace llvm;

namespace {
  struct IterateLoop : public LoopPass {
    
    static char ID;
    IterateLoop() : LoopPass(ID) {}

    virtual bool runOnLoop(Loop &L) {
      errs() << "IterateLoop: ";
//      errs()<<"isSafeToClone (): " << L.isSafeToClone () << '\n';
//      errs()<<"isLoopSimplifyForm (): " << L.isLoopSimplifyForm () << '\n';
//      errs()<<"hasDedicatedExits (): " << L.hasDedicatedExits () << '\n';
      return false;
    }

  };
}
  
char IterateLoop::ID = 0;
static RegisterPass<IterateLoop> X("iterate_loop", "IterateLoop World Pass", false, false);
