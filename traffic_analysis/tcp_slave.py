#!/usr/bin/env python
# -*- coding: utf_8 -*-
"""
 Modbus TestKit: Implementation of Modbus protocol in python
"""

import sys

import modbus_tk
import modbus_tk.defines as cst
from modbus_tk import modbus_tcp


def main(slave_id):
    """main"""

    logger = modbus_tk.utils.create_logger(name="console", record_format="%(message)s")

    try:
        #Create the server
        server = modbus_tcp.TcpServer()
        logger.info("running...")
        logger.info("enter 'quit' for closing the server")

        server.start()

        slave = server.add_slave(int(slave_id))
        #########################################
        #Add memory blocks here


        #########################################
        ###Do not modify code below this line
        while True:
            cmd = sys.stdin.readline()
            args = cmd.split(' ')

            if cmd.find('quit') == 0:
                sys.stdout.write('bye-bye\r\n')
                break

            elif args[0] == 'add_slave':
                slave_id = int(args[1])
                server.add_slave(slave_id)
                sys.stdout.write('done: slave %d added\r\n' % slave_id)

            elif args[0] == 'add_block':
                slave_id = int(args[1])
                name = args[2]
                block_type = int(args[3])
                starting_address = int(args[4])
                length = int(args[5])
                slave = server.get_slave(slave_id)
                slave.add_block(name, block_type, starting_address, length)
                sys.stdout.write('done: block %s added\r\n' % name)

            elif args[0] == 'set_values':
                slave_id = int(args[1])
                name = args[2]
                address = int(args[3])
                values = []
                for val in args[4:]:
                    values.append(int(val))
                slave = server.get_slave(slave_id)
                slave.set_values(name, address, values)
                values = slave.get_values(name, address, len(values))
                sys.stdout.write('done: values written: %s\r\n' % str(values))

            elif args[0] == 'get_values':
                slave_id = int(args[1])
                name = args[2]
                address = int(args[3])
                length = int(args[4])
                slave = server.get_slave(slave_id)
                values = slave.get_values(name, address, length)
                sys.stdout.write('done: values read: %s\r\n' % str(values))

            #else:
            #	if(args[0] != ''):
	        #        sys.stdout.write("unknown command %s\r\n" % args[0])
    finally:
        server.stop()


if __name__ == "__main__":
    main(sys.argv[1])
