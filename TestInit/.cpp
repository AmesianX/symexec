#include "llvm/Pass.h"
#include "llvm/Function.h"
#include "llvm/Support/raw_ostream.h"

using namespace llvm;

namespace {
  struct test_init : public FunctionPass {
    
    static char ID;
    TestInit() : FunctionPass(ID) {}

    virtual bool runOnFunction(Function &F) {
      errs() << "TestInit: ";
      errs().write_escaped(F.getName()) << '\n';
      return false;
    }

  };
}
  
char TestInit::ID = 0;
static RegisterPass<TestInit> X("test_init", "TestInit World Pass", false, false);
