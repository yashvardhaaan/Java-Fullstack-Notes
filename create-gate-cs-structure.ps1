# ============================================
# GATE CS Notes Structure Generator
# ============================================

$root = "GATE-CS"

$files = @(

# ==========================
# Section 1 - Engineering Mathematics
# ==========================

"$root\01-Engineering-Mathematics\01-Discrete-Mathematics.md"
"$root\01-Engineering-Mathematics\02-Propositional-and-First-Order-Logic.md"
"$root\01-Engineering-Mathematics\03-Sets.md"
"$root\01-Engineering-Mathematics\04-Relations.md"
"$root\01-Engineering-Mathematics\05-Functions.md"
"$root\01-Engineering-Mathematics\06-Partial-Orders-and-Lattices.md"
"$root\01-Engineering-Mathematics\07-Monoids.md"
"$root\01-Engineering-Mathematics\08-Groups.md"
"$root\01-Engineering-Mathematics\09-Graphs.md"
"$root\01-Engineering-Mathematics\10-Connectivity.md"
"$root\01-Engineering-Mathematics\11-Matching.md"
"$root\01-Engineering-Mathematics\12-Colouring.md"
"$root\01-Engineering-Mathematics\13-Combinatorics.md"
"$root\01-Engineering-Mathematics\14-Recurrence-Relations.md"
"$root\01-Engineering-Mathematics\15-Generating-Functions.md"

"$root\01-Engineering-Mathematics\16-Matrices.md"
"$root\01-Engineering-Mathematics\17-Determinants.md"
"$root\01-Engineering-Mathematics\18-System-of-Linear-Equations.md"
"$root\01-Engineering-Mathematics\19-Eigenvalues-and-Eigenvectors.md"
"$root\01-Engineering-Mathematics\20-LU-Decomposition.md"

"$root\01-Engineering-Mathematics\21-Limits.md"
"$root\01-Engineering-Mathematics\22-Continuity-and-Differentiability.md"
"$root\01-Engineering-Mathematics\23-Maxima-and-Minima.md"
"$root\01-Engineering-Mathematics\24-Mean-Value-Theorem.md"
"$root\01-Engineering-Mathematics\25-Integration.md"

"$root\01-Engineering-Mathematics\26-Random-Variables.md"
"$root\01-Engineering-Mathematics\27-Uniform-Distribution.md"
"$root\01-Engineering-Mathematics\28-Normal-Distribution.md"
"$root\01-Engineering-Mathematics\29-Exponential-Distribution.md"
"$root\01-Engineering-Mathematics\30-Poisson-Distribution.md"
"$root\01-Engineering-Mathematics\31-Binomial-Distribution.md"
"$root\01-Engineering-Mathematics\32-Mean-Median-Mode.md"
"$root\01-Engineering-Mathematics\33-Standard-Deviation.md"
"$root\01-Engineering-Mathematics\34-Conditional-Probability.md"
"$root\01-Engineering-Mathematics\35-Bayes-Theorem.md"

# ==========================
# Section 2 - Digital Logic
# ==========================

"$root\02-Digital-Logic\01-Boolean-Algebra.md"
"$root\02-Digital-Logic\02-Algebraic-Minimization.md"
"$root\02-Digital-Logic\03-Karnaugh-Map.md"
"$root\02-Digital-Logic\04-Tabular-Method.md"
"$root\02-Digital-Logic\05-Combinational-Circuits.md"
"$root\02-Digital-Logic\06-Sequential-Circuits.md"
"$root\02-Digital-Logic\07-Number-Representation.md"
"$root\02-Digital-Logic\08-Fixed-Point-Arithmetic.md"
"$root\02-Digital-Logic\09-Floating-Point-Arithmetic.md"

# ==========================
# Section 3 - COA
# ==========================

"$root\03-Computer-Organization-and-Architecture\01-Instruction-Set.md"
"$root\03-Computer-Organization-and-Architecture\02-Addressing-Modes.md"
"$root\03-Computer-Organization-and-Architecture\03-ALU.md"
"$root\03-Computer-Organization-and-Architecture\04-Hardwired-Control-Unit.md"
"$root\03-Computer-Organization-and-Architecture\05-Microprogrammed-Control-Unit.md"
"$root\03-Computer-Organization-and-Architecture\06-Memory-Hierarchy.md"
"$root\03-Computer-Organization-and-Architecture\07-Cache-Mapping.md"
"$root\03-Computer-Organization-and-Architecture\08-Interrupts.md"
"$root\03-Computer-Organization-and-Architecture\09-DMA.md"
"$root\03-Computer-Organization-and-Architecture\10-Instruction-Pipelining.md"
"$root\03-Computer-Organization-and-Architecture\11-Pipeline-Hazards.md"

# ==========================
# Section 4 - Programming & DS
# ==========================

"$root\04-Programming-and-Data-Structures\01-C-Programming.md"
"$root\04-Programming-and-Data-Structures\02-Recursion.md"
"$root\04-Programming-and-Data-Structures\03-Arrays.md"
"$root\04-Programming-and-Data-Structures\04-Stacks.md"
"$root\04-Programming-and-Data-Structures\05-Queues.md"
"$root\04-Programming-and-Data-Structures\06-Linked-Lists.md"
"$root\04-Programming-and-Data-Structures\07-Trees.md"
"$root\04-Programming-and-Data-Structures\08-Binary-Search-Trees.md"
"$root\04-Programming-and-Data-Structures\09-Binary-Heaps.md"
"$root\04-Programming-and-Data-Structures\10-Graphs.md"

# ==========================
# Section 5 - Algorithms
# ==========================

"$root\05-Algorithms\01-Searching.md"
"$root\05-Algorithms\02-Sorting.md"
"$root\05-Algorithms\03-Hashing.md"
"$root\05-Algorithms\04-Time-Complexity.md"
"$root\05-Algorithms\05-Space-Complexity.md"
"$root\05-Algorithms\06-Greedy.md"
"$root\05-Algorithms\07-Dynamic-Programming.md"
"$root\05-Algorithms\08-Divide-and-Conquer.md"
"$root\05-Algorithms\09-Graph-Traversals.md"
"$root\05-Algorithms\10-Minimum-Spanning-Tree.md"
"$root\05-Algorithms\11-Shortest-Path.md"

# ==========================
# Section 6 - Theory of Computation
# ==========================

"$root\06-Theory-of-Computation\01-Regular-Expressions.md"
"$root\06-Theory-of-Computation\02-Finite-Automata.md"
"$root\06-Theory-of-Computation\03-Context-Free-Grammars.md"
"$root\06-Theory-of-Computation\04-Pushdown-Automata.md"
"$root\06-Theory-of-Computation\05-Regular-Languages.md"
"$root\06-Theory-of-Computation\06-Context-Free-Languages.md"
"$root\06-Theory-of-Computation\07-Pumping-Lemma.md"
"$root\06-Theory-of-Computation\08-Turing-Machines.md"
"$root\06-Theory-of-Computation\09-Undecidability.md"

# ==========================
# Section 7 - Compiler Design
# ==========================

"$root\07-Compiler-Design\01-Lexical-Analysis.md"
"$root\07-Compiler-Design\02-Parsing.md"
"$root\07-Compiler-Design\03-Syntax-Directed-Translation.md"
"$root\07-Compiler-Design\04-Runtime-Environments.md"
"$root\07-Compiler-Design\05-Intermediate-Code-Generation.md"
"$root\07-Compiler-Design\06-Local-Optimization.md"
"$root\07-Compiler-Design\07-Data-Flow-Analysis.md"
"$root\07-Compiler-Design\08-Constant-Propagation.md"
"$root\07-Compiler-Design\09-Liveness-Analysis.md"
"$root\07-Compiler-Design\10-Common-Subexpression-Elimination.md"

)

foreach ($file in $files) {

    $folder = Split-Path $file -Parent

    if (!(Test-Path $folder)) {
        New-Item -ItemType Directory -Path $folder -Force | Out-Null
    }

    if (!(Test-Path $file)) {
        New-Item -ItemType File -Path $file | Out-Null
    }
}

Write-Host ""
Write-Host "==========================================" -ForegroundColor Green
Write-Host " GATE CS Structure Created Successfully!"
Write-Host "==========================================" -ForegroundColor Green