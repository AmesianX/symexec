#include "llvm/Pass.h"
#include "llvm/Function.h"
#include "llvm/Support/raw_ostream.h"

using namespace llvm;

namespace {
  struct ${MyPass} : public FunctionPass {
    
    static char ID;
    ${MyPass}() : FunctionPass(ID) {}

    virtual bool runOnFunction(Function &F) {
      errs() << "${MyPass}: ";
      errs().write_escaped(F.getName()) << '\n';
      return false;
    }

  };
}
  
char ${MyPass}::ID = 0;
static RegisterPass<${MyPass}> X("${MyOpt}", "${MyPass} World Pass", false, false);
