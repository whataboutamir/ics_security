#!/usr/bin/env python
# -*- coding: utf_8 -*-
"""
 Modbus TestKit: Implementation of Modbus protocol in python
"""

import modbus_tk
import modbus_tk.defines as cst
from modbus_tk import modbus_tcp


def main():
    """main"""
    logger = modbus_tk.utils.create_logger("console")

    try:
        connection_41 = modbus_tcp.TcpMaster(host='192.168.1.41')
        connection_41.set_timeout(5.0)
        logger.info("Connected to 192.168.1.41")
        #########################################
        #Connect to other slave(s) here
        
        #########################################
        #add queries to follow the assignment pdf, example queries have been provided for you 
        logger.info(connection_41.execute(41, cst.READ_COILS, 0, 2))
        logger.info(connection_41.execute(41, cst.WRITE_MULTIPLE_COILS, 0, output_value=[1, 1]))

    except modbus_tk.modbus.ModbusError as exc:
        logger.error("%s- Code=%d", exc, exc.get_exception_code())

if __name__ == "__main__":
    main()
