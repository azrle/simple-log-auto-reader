requires 'perl', '5.008001';
requires 'File::Slurp',         '9999.19';
requires 'File::Monitor',       '1.00';
requires 'Term::ANSIScreen',    '1.50';
requires 'Time::HiRes',         '1.9726';

on 'configure' => sub {
   requires 'Module::Build', '0.38';
   requires 'Module::CPANfile', '0.9010';
};

on 'test' => sub {
   requires 'Test::More', '0.98';
};
