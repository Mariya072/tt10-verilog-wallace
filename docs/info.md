## How it works

This project implements a 4×4 Wallace Tree Multiplier. It takes two 4-bit inputs `A[3:0]` and `B[3:0]`  and outputs an 8-bit product `P[7:0]`.The multiplication is performed using the Wallace Tree architecture, which minimizes propagation delay by reducing partial products in a tree-like structure using full adders and half adders. The final two rows are summed using a carry-propagate adder to produce the output.This approach is faster than traditional ripple-carry multipliers and is widely used in high-performance arithmetic circuits.

---

## How to test

1. Connect your inputs:
   - Provide 4-bit operand A through `ui_in[3:0]`
   - Provide 4-bit operand B through `ui_in[7:4]`

2. Observe the output:
   - The 8-bit result (A × B) will appear on `uo_out[7:0]`

Example:
- `ui_in = 8'b10010110`  
  - A = 0110 (6), B = 1001 (9)  
  - `uo_out = 8'b00101110` → Decimal 54 (6×9)



---

## External hardware

None.

