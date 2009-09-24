#include <IOKit/IOService.h>

class net_trajano_driver_InsomniaT : public IOService
{
	OSDeclareDefaultStructors(net_trajano_driver_InsomniaT)
	friend IOReturn handleSleepWakeInterest( void * target, void * refCon,
															UInt32 messageType, IOService * provider,
															void * messageArgument, vm_size_t argSize );
private:
	OSObject* fAppleClamshellCausesSleep;
	IONotifier* fNotifier;

	virtual bool isSleepEnabled();
	virtual void disableSleep();
	virtual void enableSleep();
	
public:
    virtual bool init(OSDictionary *dictionary = NULL);
    virtual void free(void);
	virtual IOService *probe(IOService *provider, SInt32 *score);
    virtual bool start(IOService *provider);
    virtual void stop(IOService *provider);
};