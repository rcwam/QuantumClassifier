namespace Quantum.Bell2
{
    open Microsoft.Quantum.Primitive;
    open Microsoft.Quantum.Canon;
    
    operation SetQubit (desired: Result, q1: Qubit) : Unit {
        let current = M(q1);

        if (desired != current)
        {
            X(q1);
        }
    }

	operation BellTest (count : Int, initial: Result) : (Int, Int, Int)
    {
        mutable numOnes = 0;
		mutable agree = 0;

        using (qubits = Qubit[2])
        {
            for (test in 1..count)
            {
                SetQubit (initial, qubits[0]);
				SetQubit (Zero, qubits[1]);

				H(qubits[0]);
				CNOT(qubits[0], qubits[1]);
                let res = M (qubits[0]);

				if(M (qubits[1]) == res)
				{
					set agree = agree + 1;
				}

				

                // Count the number of ones we saw:
                if (res == One)
                {
                    set numOnes = numOnes + 1;
                }
            }
            SetQubit(Zero, qubits[0]);
			SetQubit(Zero, qubits[1]);
        }

        // Return number of times we saw a |0> and number of times we saw a |1>
        return (count-numOnes, numOnes, agree);
    }
}
