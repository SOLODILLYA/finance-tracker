import { useState } from 'react';
import axios from 'axios';
import type { AxiosResponse } from 'axios';

interface RegisterResponse {
  message: string;
}

export default function Register() {
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');

  const handleSubmit = async (e: React.FormEvent<HTMLFormElement>) => {
    e.preventDefault();
    try {
      const res: AxiosResponse<RegisterResponse> = await axios.post(
        'http://localhost:8080/api/auth/register',
        { email, password }
      );
      console.log('Register success:', res.data);
      alert('Registered successfully!');
    } catch (err) {
      console.error('Register failed', err);
      alert('Register failed');
    }
  };

  return (
    <div>
      <h1>Register</h1>
      <form onSubmit={handleSubmit}>
        <input
          type="email"
          placeholder="Email"
          value={email}
          onChange={(e) => setEmail(e.target.value)}
        />
        <br />
        <input
          type="password"
          placeholder="Password"
          value={password}
          onChange={(e) => setPassword(e.target.value)}
        />
        <br />
        <button type="submit">Register</button>
      </form>
    </div>
  );
}
