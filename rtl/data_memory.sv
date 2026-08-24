/* DATA MEMORY MODULE
    FOR STORE OPERATION:
        - Recieves formatted data
        - Shift bitmask to account for alignment
        - Write into memory for each activated bitmask
    FOR LOAD OPERATION:
        - Recieves address
        - Fetch and shift data to account for alignment
        - Send data out to formatter
